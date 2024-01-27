--1st and 4th query
create index coords_dates_index on positions((t::date),lon,lat);
--2nd query
create index greek_flag_index on vessels(flag,id,type) where flag='Greece';
--3rd query, not used on max_parallel_workers_per_gather=8
create index positions_speed_30_index on positions(speed) where speed>30;
create index vessels_type_index on vessels(type);
--4th query
create index id_coords_dates_index on positions(vessel_id,(t::date),lon,lat);
--5th query
create index id_speed_dates_index on positions(vessel_id,(t::date),speed) where speed=0;

