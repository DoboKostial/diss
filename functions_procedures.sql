CREATE OR REPLACE FUNCTION public.count_pieces_more_1(_datation1 smallint, _datation2 smallint, _material character varying)
 RETURNS TABLE(id_polygon smallint, season smallint, material character varying, datation smallint, count smallint)
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN QUERY 
SELECT id_polygon, season, material, datation, count(*)
FROM tab_finds
WHERE material = '_material' AND datation BETWEEN _datation1 AND _datation2
GROUP BY id_polygon, season, material, datation
HAVING count(*) > 1
ORDER BY season;
END; $function$
;


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


CREATE OR REPLACE FUNCTION public.frequency_vaha_3_sezon(_sezona integer)
 RETURNS bigint
 LANGUAGE sql
AS $function$
    SELECT SUM(vaha)
    FROM tab_finds tf2
    WHERE id_polygon
    IN
        (SELECT tf.id_polygon
            FROM
                tab_finds tf
            INNER JOIN tab_polygony_base_stat tpbs ON tf.id_polygon = tpbs.id_polygon
            WHERE tpbs.season_2_finds = true
                AND tpbs.season_3_finds = true
                AND tpbs.season_4_finds = true)
      AND tf2.season = _sezona;
$function$
;


CREATE OR REPLACE FUNCTION public.weight_loop_for_polygons(_sezona integer, _material character varying)
 RETURNS TABLE(polygon integer, soucet bigint)
 LANGUAGE sql
AS $function$
	
		SELECT id_polygon, SUM(vaha) soucet_vahy 
		FROM tab_finds
		WHERE material = _material AND season = _sezona
		GROUP BY id_polygon;
	
$function$
;