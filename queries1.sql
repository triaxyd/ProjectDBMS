
-- i. *
select count(lon) as longitude,count(lat) as latitude , t::date
from positions
group by t::date
order by longitude,latitude desc;


-- ii. **
with greek_vessels as
(
    select type
    from vessels
    where flag like '%Greece%'
)

with view_greek as
(
    select count(*) as number_of_greek, vessel_types.description, vessel_types.code
    from vessel_types inner join greek_vessels on vessel_types.code = greek_vessels.type
    group by vessel_types.code
)

/*
select count(*) as number_of_greek, vessel_types.description
from vessels inner join vessel_types on vessels.type = vessel_types.code
where flag like 'Greece'
group by vessel_types.code;
*/

-- iii. ***
with ships_speed_greater_30 as
(
    select positions.vessel_id 
    from positions 
    where positions.speed>30
)

select vessel_types.description as vessel_type,count(*) as ships_total 
from ships_speed_greater_30 inner join vessels on ships_speed_greater_30.vessel_id = vessels.id
    inner join vessel_types on vessels.type = vessel_types.code
group by vessel_types.description;


-- iv. ****
with passenger_vessels as
(
    select vessels.id
    from vessel_types inner join vessels on vessel_types.code = vessels.type
    where vessel_types.description like 'Passenger%'
)

select count(*) as vessels_per_day
from positions inner join passenger_vessels on positions.vessel_id = passenger_vessels.id
group by positions.t::date 
having positions.t::date >= '2019-08-14' and positions.t::date <= '2019-08-18'




-- v. ******
with cargo_vessels as
(
    select vessels.id
    from vessel_types inner join vessels on vessel_types.code = vessels.type
    where vessel_types.description like 'Cargo%'
)

--some point in period 15/08/2019-18/08/2019
select distinct(cargo_vessels.id) as cargo_static
from cargo_vessels inner join positions on cargo_vessels.id = positions.vessel_id
where positions.speed = 0 and (t::date between '2019-08-15' and '2019-08-18');  

-- every day in the period 12/08/2019-19/08/2019
select cargo_vessels.id
from cargo_vessels inner join positions on cargo_vessels.id = positions.vessel_id
where positions.speed = 0 and t>='2019-08-12' and t<='2019-08-19'
group by cargo_vessels.id 
having count(distinct date(t)) = (date '2019-08-19' - date '2019-08-12');