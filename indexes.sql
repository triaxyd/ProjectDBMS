--1st query
create index dates_coords_index on positions((t::date),lon,lat);

--2nd query
create index greek_flag_index on vessels(flag,id,type) where flag='Greece';

--3rd query
create index vessel_id_speed_index on positions(vessel_id,speed);
--create index vessels_type_index on vessels(type); --doesnt improve time

--4th query
create index vessel_id_dates_coords_index on positions(vessel_id,(t::date),lon,lat);

--5th query
create index vessel_id_speed_dates_index on positions(vessel_id,(t::date),speed) where speed=0;

--4th and 5th queries
create index type_desc_index on vessel_types(code,description);


