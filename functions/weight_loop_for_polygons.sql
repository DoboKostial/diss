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