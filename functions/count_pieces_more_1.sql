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