CREATE TABLE public.tab_finds (
	id_sack int2 NULL,
	id_polygon int2 NULL,
	material varchar(255) NULL,
	datation int2 NULL,
	delka int2 NULL,
	sirka int2 NULL,
	tloustka int2 NULL,
	vaha int2 NULL,
	omletost bool NULL,
	poznamka varchar(255) NULL,
	season int2 NULL,
	id_aut int4 NOT NULL,
	concat_season_id_polygon bpchar(4) NULL,
	CONSTRAINT tab_finds_pkey PRIMARY KEY (id_aut)
);

CREATE TABLE public.tab_polygony (
	id_polygon int2 NULL,
	polygon_area int4 NULL,
	area_koeficient numeric NULL
);

CREATE TABLE public.tab_polygony_sezony (
	"ID_polygon" int2 NULL,
	"Datum" date NULL,
	sirka_trasy int2 NULL,
	rozestup_linii int2 NULL,
	autor varchar(60) NULL,
	zemedel_prace int2 NULL,
	povrch int2 NULL,
	zvetralost int2 NULL,
	hustota_porostu int2 NULL,
	predchozi_plodina varchar(100) NULL,
	aktualni_plodina varchar(100) NULL,
	nalezy bool NULL,
	poznamka varchar(255) NULL,
	season int2 NULL,
	koeficient_rozestupy float4 NULL
);