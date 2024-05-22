-- this function prints the table with most frequent surface type for every season
-- no parameters, using CTE
-- dobo@dobo.sk
CREATE OR REPLACE FUNCTION public.func_show_most_common_surface()
 RETURNS TABLE(season_ integer, zemedel_prace_ integer, povrch_ integer, zvetralost_ integer, hustota_porostu_ integer, predchozi_plodina_ character varying, aktualni_plodina_ character varying, vlhkost_ character varying, pocet_ integer)
 LANGUAGE sql
AS $function$    
WITH surface_frequencies AS (
SELECT
        tps.season,
        tps.zemedel_prace,
        tps.povrch,
        tps.zvetralost,
        tps.hustota_porostu,
        tps.predchozi_plodina,
        tps.aktualni_plodina,
        tps.vlhkost,
        COUNT(*) AS frequency
    FROM 
        tab_polygony_sezony tps
    GROUP BY 
        season,
        zemedel_prace,
        povrch,
        zvetralost,
        hustota_porostu,
        predchozi_plodina,
        aktualni_plodina,
        vlhkost
),
most_common_surface AS (
    SELECT DISTINCT ON (season)
        season,
        zemedel_prace,
        povrch,
        zvetralost,
        hustota_porostu,
        predchozi_plodina,
        aktualni_plodina,
        vlhkost,
        frequency
    FROM 
        surface_frequencies
    ORDER BY 
        season, frequency DESC
)
SELECT * FROM most_common_surface;
$function$
;
