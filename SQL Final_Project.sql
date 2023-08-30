create database FinalProject;
use FinalProject;

create table Station (
    ID int primary key,
    CITY char(20),
    STATE char(2),
    LAT_N int,
    LONG_W int);

insert into Station (ID, CITY, STATE, LAT_N, LONG_W) 
values (13, 'Phoenix', 'AZ', 33, 112);
insert into Station (ID, CITY, STATE, LAT_N, LONG_W) 
values (44, 'Denver', 'CO', 40, 105);
insert into Station (ID, CITY, STATE, LAT_N, LONG_W) 
values (66, 'Caribou', 'ME', 47, 68);

select * from station;

select * from station where LAT_N > 39.7;

create table STATS (
    ID int,
    MONTH int,
    TEMP_F decimal(5,2),
    RAIN_I decimal(5,2),
    primary key (ID, MONTH),
    foreign key (ID) references Station(ID)
);

insert into STATS (ID, MONTH, TEMP_F, RAIN_I) 
values (13, 1, 57.4, 0.31);
insert into STATS (ID, MONTH, TEMP_F, RAIN_I) 
values (13, 7, 91.7, 5.15);
insert into STATS (ID, MONTH, TEMP_F, RAIN_I)
 values (44, 1, 27.3, 0.18);
insert into STATS (ID, MONTH, TEMP_F, RAIN_I) 
values (44, 7, 74.8, 2.11);
insert into STATS (ID, MONTH, TEMP_F, RAIN_I) 
values (66, 1, 6.7, 2.1);
insert into STATS (ID, MONTH, TEMP_F, RAIN_I) 
values (66, 7, 65.8, 4.52);

select * from Stats;

select s.CITY, avg(st.TEMP_F) as AverageTemperature, MIN(st.TEMP_F) as MinTemperature, MAX(st.TEMP_F) as MaxTemperature
from Station s
join STATS st on s.ID = st.ID
group by s.CITY;

select st.MONTH, st.RAIN_I, st.ID, s.CITY
from STATS st
join Station s on st.ID = s.ID
order by st.MONTH, st.RAIN_I desc;

select st.TEMP_F, s.CITY, s.LAT_N
from STATS st
join Station s on st.ID = s.ID
where st.MONTH = 7
order by st.TEMP_F asc;

select s.CITY, MAX(st.TEMP_F) as MaxTemperature, MIN(st.TEMP_F) as MinTemperature, avg(st.RAIN_I) as AverageRainfall
from Station s
join STATS st on s.ID = st.ID
group by s.CITY;

select s.CITY,
       st.MONTH,
       ROUND((st.TEMP_F - 32) * 5/9, 2) AS Temp_Celsius,
       ROUND(st.RAIN_I * 2.54, 2) AS Rainfall_Centimeters
from Station s
join STATS st on s.ID = st.ID;

SET SQL_SAFE_UPDATES = 0;

update STATS
set RAIN_I = RAIN_I + 0.01;

select * from stats;

update STATS
set TEMP_F = 74.9
where ID in (
    select ID
    from Station
    where CITY = 'Denver'
) and MONTH = 7;
