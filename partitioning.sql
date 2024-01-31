-- partitioned positions
drop table if exists Positions_Partitioned;
create table Positions_Partitioned    	 
(
	id integer,
	vessel_id varchar,
	t timestamp,
	lon numeric(7,5),
	lat numeric(7,5),
	heading int,
	course numeric(4,1),
	speed numeric(4,1),

	primary key (id,t), -- we need t in primary key in order to work
	foreign key (vessel_id) references Vessels(id)
) partition by range(t);

-- create the partitioned tables
create table positions_2019_08_01 partition of Positions_Partitioned
for values from ('2019-08-01') to ('2019-08-02');

create table positions_2019_08_02 partition of Positions_Partitioned
for values from ('2019-08-02') to ('2019-08-03');

create table positions_2019_08_03 partition of Positions_Partitioned
for values from ('2019-08-03') to ('2019-08-04');

create table positions_2019_08_04 partition of Positions_Partitioned
for values from ('2019-08-04') to ('2019-08-05');

create table positions_2019_08_05 partition of Positions_Partitioned
for values from ('2019-08-05') to ('2019-08-06');

create table positions_2019_08_06 partition of Positions_Partitioned
for values from ('2019-08-06') to ('2019-08-07');

create table positions_2019_08_07 partition of Positions_Partitioned
for values from ('2019-08-07') to ('2019-08-08');

create table positions_2019_08_08 partition of Positions_Partitioned
for values from ('2019-08-08') to ('2019-08-09');

create table positions_2019_08_09 partition of Positions_Partitioned
for values from ('2019-08-09') to ('2019-08-10');

create table positions_2019_08_10 partition of Positions_Partitioned
for values from ('2019-08-10') to ('2019-08-11');

create table positions_2019_08_11 partition of Positions_Partitioned
for values from ('2019-08-11') to ('2019-08-12');

create table positions_2019_08_12 partition of Positions_Partitioned
for values from ('2019-08-12') to ('2019-08-13');

create table positions_2019_08_13 partition of Positions_Partitioned
for values from ('2019-08-13') to ('2019-08-14');

create table positions_2019_08_14 partition of Positions_Partitioned
for values from ('2019-08-14') to ('2019-08-15');

create table positions_2019_08_15 partition of Positions_Partitioned
for values from ('2019-08-15') to ('2019-08-16');

create table positions_2019_08_16 partition of Positions_Partitioned
for values from ('2019-08-16') to ('2019-08-17');

create table positions_2019_08_17 partition of Positions_Partitioned
for values from ('2019-08-17') to ('2019-08-18');

create table positions_2019_08_18 partition of Positions_Partitioned
for values from ('2019-08-18') to ('2019-08-19');

create table positions_2019_08_19 partition of Positions_Partitioned
for values from ('2019-08-19') to ('2019-08-20');

create table positions_2019_08_26 partition of Positions_Partitioned
for values from ('2019-08-26') to ('2019-08-27');

create table positions_2019_08_27 partition of Positions_Partitioned
for values from ('2019-08-27') to ('2019-08-28');

create table positions_2019_08_28 partition of Positions_Partitioned
for values from ('2019-08-28') to ('2019-08-29');

create table positions_2019_08_29 partition of Positions_Partitioned
for values from ('2019-08-29') to ('2019-08-30');

create table positions_2019_08_30 partition of Positions_Partitioned
for values from ('2019-08-30') to ('2019-08-31');



--New Queries + Indexes

-- i. *
select t as coord_date, count(distinct lon || ',' || lat) as coords
from positions_partitioned 
group by coord_date
order by coords desc;

create index partitioned_dates_coords_index on positions_partitioned(t,lon,lat);


-- ii. **
-- Positions table is not used for query 2,no need for index.


-- iii. ***
with ships_speed_greater_30 as
(
    select pp.vessel_id, vessels.type
    from positions_partitioned as pp 
    join vessels on pp.vessel_id = vessels.id
    where pp.speed > 30
),
count_of_vessels as
( 
    select type, count(*) as vessels_total
    from ships_speed_greater_30
    group by type
)

select distinct(ships_speed_greater_30.vessel_id) , count_of_vessels.type,count_of_vessels.vessels_total 
from ships_speed_greater_30 join count_of_vessels on ships_speed_greater_30.type= count_of_vessels.type
order by type desc;

create index partitioned_vessel_id_speed_index on positions_partitioned(vessel_id,speed) where speed>30;



-- iv. ****
with passenger_vessels as
(
	select vessels.id
	from vessel_types join vessels on vessel_types.code = vessels.type
	where vessel_types.description like 'Passenger%'
)
select count(distinct lon || ',' || lat) as coords_per_day, pp.t as date
from positions_partitioned as pp join passenger_vessels on pp.vessel_id = passenger_vessels.id
group by pp.t
having pp.t >= '2019-08-14' and pp.t <= '2019-08-18'

create index partitioned_vessel_id_dates_coords_index on positions_partitioned(vessel_id,t,lon,lat);



-- v. *****
with cargo_vessels as
(
	select vessels.id
	from vessel_types join vessels on vessel_types.code = vessels.type
	where vessel_types.description like 'Cargo%'
)

--some point in period 15/08/2019-18/08/2019
select distinct(cargo_vessels.id) as cargo_static
from cargo_vessels join positions_partitioned as pp on cargo_vessels.id = pp.vessel_id
where pp.speed = 0 and (t between '2019-08-15' and '2019-08-18');  

-- every day in the period 12/08/2019-19/08/2019
select cargo_vessels.id
from cargo_vessels join positions_partitioned as pp on cargo_vessels.id = pp.vessel_id
where pp.speed = 0 and t>='2019-08-12' and t<='2019-08-19'
group by cargo_vessels.id
having count(distinct t) = (date '2019-08-19' - date '2019-08-12');

create index partitioned_vessel_id_dates_speed_index on positions_partitioned(vessel_id,t,speed) where speed = 0;

