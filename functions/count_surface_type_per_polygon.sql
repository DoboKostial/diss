/*
 * This function concatenates types of fileld surface in all polygons and
 * make a base statistics of surface type count per season.
 * author: dobo@dobo.sk
 * 2021/08
 * */

CREATE OR REPLACE FUNCTION public.count_surface_types_per_polygon()
		RETURNS TABLE 
		(sezona int2,
		pocet_typu_povrchu int2)
	LANGUAGE plpgsql
AS $$
	BEGIN
		RETURN QUERY
			SELECT season, COUNT(DISTINCT (CONCAT_WS('-',zemedel_prace, 
														povrch, 
														zvetralost, 
														hustota_porostu, 
														predchozi_plodina, 
														aktualni_plodina))) as pocet_typu_povrchu
			FROM tab_polygony_sezony
			GROUP BY season;
	END;
$$
;
