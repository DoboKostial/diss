CREATE OR REPLACE FUNCTION public.frequency_count_3_sezon(_sezona integer)
 RETURNS TABLE(pocet bigint)
 LANGUAGE sql
AS $function$
SELECT COUNT(id_polygon) FROM tab_finds tf2
WHERE id_polygon IN
(SELECT distinct(tf.id_polygon)
            FROM
                tab_finds tf
            INNER JOIN tab_polygony_base_stat tpbs ON tf.id_polygon = tpbs.id_polygon
            WHERE tpbs.season_2_finds = true
                AND tpbs.season_3_finds = true
                AND tpbs.season_4_finds = true)

 AND tf2.season = _sezona
 GROUP BY id_polygon;
$function$
;