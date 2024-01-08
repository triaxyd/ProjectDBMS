
-- i. *
select date(t) as day, count(*) as coordinate_count 
from positions
group by day
order by coordinate_count desc;


-- ii. **
select vessel_types.code,count(vessels.id) 
from vessel_types left join vessels on vessel_types.code = vessels.type
and vessels.flag = 'Greece'
group by vessel_types.code;

-- iii. ***
with ships_speed_greater_30 as
(
    select positions.vessel_id 
    from positions 
    where positions.speed>30
)

select vessel_types.description as vessel_type,count(*) as ships_total 
from ships_speed_greater_30 join vessels on ships_speed_greater_30.vessel_id = vessels.id
    join vessel_types on vessels.type = vessel_types.code
group by vessel_types.description;


-- iv. ****
/* 
select date(positions.t) as day, count(*) as coordinate_count
from positions
join vessels on positions.vessel_id = vessels.id
where vessels.type between 60 and 69
and positions.t between '2019-08-14'::timestamp and '2019-08-19'::timestamp
group by day;
*/

with passenger_vessels as
(
    select vessels.id
    from vessel_types join vessels on vessel_types.code = vessels.type
    where vessel_types.description like 'Passenger%'
)

select count(*) as vessels_per_day
from positions join passenger_vessels on positions.vessel_id = passenger_vessels.id
group by positions.t::date 
having positions.t::date >= '2019-08-14' and positions.t::date <= '2019-08-18'


-- v. ******
with cargo_vessels as
(
    select vessels.id
    from vessel_types join vessels on vessel_types.code = vessels.type
    where vessel_types.description like 'Cargo%'
)

--some point in period 15/08/2019-18/08/2019
select distinct(cargo_vessels.id) as cargo_static
from cargo_vessels join positions on cargo_vessels.id = positions.vessel_id
where positions.speed = 0 and (t::date between '2019-08-15' and '2019-08-18');  

-- every day in the period 12/08/2019-19/08/2019
select cargo_vessels.id
from cargo_vessels join positions on cargo_vessels.id = positions.vessel_id
where positions.speed = 0 and t>='2019-08-12' and t<='2019-08-19'
group by cargo_vessels.id 
having count(distinct date(t)) = (date '2019-08-19' - date '2019-08-12');