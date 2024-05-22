-- this function shows the number of various surface types for specific season.
-- parameters: number of season (INT) and number of rows (INT) you wanna get
-- dobo@dobo.sk
CREATE OR REPLACE FUNCTION public.func_list_surfaces_per_season(var_season integer, var_rowcount integer)
 RETURNS TABLE(zemedel_prace_ integer, povrch_ integer, zvetralost_ integer, hustota_porostu_ integer, predchozi_plodina_ character varying, aktualni_plodina_ character varying, vlhkost_ character varying, surf_sum_ bigint)
 LANGUAGE plpgsql
AS $function$
	BEGIN
return query(
SELECT 
    zemedel_prace,
    povrch,
    zvetralost,
    hustota_porostu,
    predchozi_plodina,
    aktualni_plodina,
    vlhkost,
    COUNT(*) AS fact_sum
FROM 
    public.tab_polygony_sezony tps 
where season = var_season
GROUP BY 
    zemedel_prace,
    povrch,
    zvetralost,
    hustota_porostu,
    predchozi_plodina,
    aktualni_plodina,
    vlhkost
ORDER BY 
    fact_sum desc
    limit var_rowcount);
	END;
$function$
;
