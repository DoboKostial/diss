-- this function retrieves data from DB and creates a table for further analysis by General Linear Model - Repeated Measures
-- it retrieves the surfaces of polygons in every season and calculates (by agregate functions) the number of finds per polygon
-- there are 4 parameters/variables to define the resultset:
-- - p_material = "what kind of material You wanna retrieve"
-- - p_datation_before = delimitation of material datation from bottom
-- - p_datation_after = delimitation of material datation from above
-- - p_exclude_season = "do You wanna exclude some season from retrieving?"
-- dobo@dobo.sk

CREATE OR REPLACE FUNCTION public.func_get_polygon_data_for_glm(p_material character varying, p_datation_before integer, p_datation_after integer, p_exclude_season integer DEFAULT NULL::integer)
 RETURNS TABLE(id_polygon integer, season integer, zemedel_prace integer, povrch integer, zvetralost integer, hustota_porostu integer, predchozi_plodina character varying, aktualni_plodina character varying, nalezy boolean, vlhkost character varying, pocet_keramiky bigint)
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN QUERY
    SELECT 
        p.id_polygon,
	p.season,
        p.zemedel_prace,
        p.povrch,
        p.zvetralost,
        p.hustota_porostu,
        p.predchozi_plodina,
        p.aktualni_plodina,
        p.nalezy,
        p.vlhkost,
        COALESCE(f.pocet_keramiky, 0) AS pocet_keramiky
    FROM 
        tab_polygony_sezony p
    LEFT JOIN 
        (SELECT 
            f.id_polygon,
            f.season,
            COUNT(*) AS pocet_keramiky
         FROM 
            tab_finds f
         WHERE 
            f.material = p_material AND
            (p_datation_before IS NULL OR f.datation >= p_datation_before) AND
            (p_datation_after IS NULL OR f.datation <= p_datation_after)
         GROUP BY 
            f.id_polygon, f.season) f
    ON 
        p.id_polygon = f.id_polygon AND p.season = f.season
    WHERE 
        p.nalezy = true AND
        (p_exclude_season IS NULL OR p.season != p_exclude_season);
END;
$function$
;
