
-- i.
select count(lon) as counted , t::date
from positions
group by t::date
order by counted desc;

-- ii.

select count(*) as number_of_greek_per_type
from vessels inner join vessel_types on vessels.type = vessel_types.code
where flag like 'Greece'
group by vessel_types.code;


-- iii. 


-- iv.


-- v.