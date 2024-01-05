--VESSEL_TYPES
Create table Vessel_Types
(
    code integer,
    description varchar,

    primary key (code)
);


--VESSELS 
create table Vessels
(
	id varchar,
	type integer,
	flag varchar,

    primary key(id),
    foreign key(type) references Vessel_Types(code)
);


--POSITIONS
create table Positions              
(
    id integer,
    vessel_id varchar,
    t timestamp,
    lon numeric(7,5),
    lat numeric(7,5),
    heading int,
    course numeric(4,1),
    speed numeric(4,1),

    primary key (id),
    foreign key (vessel_id) references Vessels(id)
);
