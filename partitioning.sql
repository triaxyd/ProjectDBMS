
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

    primary key (id,t), -- doensn't work without pk t
    foreign key (vessel_id) references Vessels(id)
) partition by range(t);


-- create the partitioned tables
create table positions_2019_08_01 partition of Positions_Partitioned
for values from ('2019-08-01 00:00:00'::timestamp) to ('2019-08-02 00:00:00'::timestamp);

create table positions_2019_08_02 partition of Positions_Partitioned
for values from ('2019-08-02 00:00:00'::timestamp) to ('2019-08-03 00:00:00'::timestamp);

create table positions_2019_08_03 partition of Positions_Partitioned
for values from ('2019-08-03 00:00:00'::timestamp) to ('2019-08-04 00:00:00'::timestamp);

create table positions_2019_08_04 partition of Positions_Partitioned
for values from ('2019-08-04 00:00:00'::timestamp) to ('2019-08-05 00:00:00'::timestamp);

create table positions_2019_08_05 partition of Positions_Partitioned
for values from ('2019-08-05 00:00:00'::timestamp) to ('2019-08-06 00:00:00'::timestamp);

create table positions_2019_08_06 partition of Positions_Partitioned
for values from ('2019-08-06 00:00:00'::timestamp) to ('2019-08-07 00:00:00'::timestamp);

create table positions_2019_08_07 partition of Positions_Partitioned
for values from ('2019-08-07 00:00:00'::timestamp) to ('2019-08-08 00:00:00'::timestamp);

create table positions_2019_08_08 partition of Positions_Partitioned
for values from ('2019-08-08 00:00:00'::timestamp) to ('2019-08-09 00:00:00'::timestamp);

create table positions_2019_08_09 partition of Positions_Partitioned
for values from ('2019-08-09 00:00:00'::timestamp) to ('2019-08-10 00:00:00'::timestamp);

create table positions_2019_08_10 partition of Positions_Partitioned
for values from ('2019-08-10 00:00:00'::timestamp) to ('2019-08-11 00:00:00'::timestamp);

create table positions_2019_08_11 partition of Positions_Partitioned
for values from ('2019-08-11 00:00:00'::timestamp) to ('2019-08-12 00:00:00'::timestamp);

create table positions_2019_08_12 partition of Positions_Partitioned
for values from ('2019-08-12 00:00:00'::timestamp) to ('2019-08-13 00:00:00'::timestamp);

create table positions_2019_08_13 partition of Positions_Partitioned
for values from ('2019-08-13 00:00:00'::timestamp) to ('2019-08-14 00:00:00'::timestamp);

create table positions_2019_08_14 partition of Positions_Partitioned
for values from ('2019-08-14 00:00:00'::timestamp) to ('2019-08-15 00:00:00'::timestamp);

create table positions_2019_08_15 partition of Positions_Partitioned
for values from ('2019-08-15 00:00:00'::timestamp) to ('2019-08-16 00:00:00'::timestamp);

create table positions_2019_08_16 partition of Positions_Partitioned
for values from ('2019-08-16 00:00:00'::timestamp) to ('2019-08-17 00:00:00'::timestamp);

create table positions_2019_08_17 partition of Positions_Partitioned
for values from ('2019-08-17 00:00:00'::timestamp) to ('2019-08-18 00:00:00'::timestamp);

create table positions_2019_08_18 partition of Positions_Partitioned
for values from ('2019-08-18 00:00:00'::timestamp) to ('2019-08-19 00:00:00'::timestamp);

create table positions_2019_08_19 partition of Positions_Partitioned
for values from ('2019-08-19 00:00:00'::timestamp) to ('2019-08-20 00:00:00'::timestamp);

create table positions_2019_08_26 partition of Positions_Partitioned
for values from ('2019-08-26 00:00:00'::timestamp) to ('2019-08-27 00:00:00'::timestamp);

create table positions_2019_08_27 partition of Positions_Partitioned
for values from ('2019-08-27 00:00:00'::timestamp) to ('2019-08-28 00:00:00'::timestamp);

create table positions_2019_08_28 partition of Positions_Partitioned
for values from ('2019-08-28 00:00:00'::timestamp) to ('2019-08-29 00:00:00'::timestamp);

create table positions_2019_08_29 partition of Positions_Partitioned
for values from ('2019-08-29 00:00:00'::timestamp) to ('2019-08-30 00:00:00'::timestamp);

create table positions_2019_08_30 partition of Positions_Partitioned
for values from ('2019-08-30 00:00:00'::timestamp) to ('2019-08-31 00:00:00'::timestamp);

