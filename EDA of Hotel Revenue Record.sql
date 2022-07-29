# Shape of Data

# No of Rows of year 2018, year2019, year 2020

select count(*) as "No of Rows" from hotel_revenue_record.year2018;


# No of columns of year2018, year2019, year2020

select count(*) as "No of columns" from information_schema.columns where table_name='year2018';

# view selected columns

select h.hotel, h.lead_time, h.adults,h.children,h.babies from hotel_revenue_record.year2018 h
where h.adults=2;

# Distinct values of Market_segment

select distinct market_segment, count(*)as "No of Rows" from hotel_revenue_record.year2018
group by market_segment;

# Finding Distinct values of stays_in_week_nights with market segment

select stays_in_week_nights, count(distinct market_segment)as "market segment" from hotel_revenue_record.year2018
group by stays_in_week_nights
order by 2 desc;

# Merging Tables as hotels

select*from year2018
union 
select*from year2019
union 
select*from year2020 as hotels;

# Revenue of the hotel in the year 2018

select arrival_date_year,
sum((stays_in_week_nights+stays_in_weekend_nights)*adr)as revenue
from year2018
group by arrival_date_year;

# inner join of tables year2018 and year2019

select*from year2018 inner join year2019
on year2018.market_segment=year2019.market_segment;

# Left join of tables year2019, market_segments, and meal

select*from year2019 left join market_segments
on year2019.market_segment=market_segments.market_segment
left join meal
on year2019.meal=meal.meal;

# Right join of tables year2020, market_segment, and Meal

select y.deposit_type,y.meal,y.market_segment,m.Discount,m.market_segment,ml.Cost,ml.meal from year2019 y Right join market_segments m
on y.market_segment=m.market_segment
right join meal ml
on y.meal=ml.meal;

# Cross join of year2020 and meal

select*from year2020 cross join meal;

# Use of operator And, OR, and Not

select y.country,y.market_segment from year2020 y
where country="GBR" and market_segment="online TA";

select y.meal, y.country from year2020 y
where meal="HB" or country="Fra";

select y.meal, y.country,y.reserved_room_type from year2020 y
where (meal="HB" or country="Fra") and reserved_room_type="A";

select y.distribution_channel,y.market_segment from year2020  y
where not distribution_channel="TA/TO";

select y.distribution_channel,y.market_segment from year2020  y
where not (distribution_channel="TA/TO" or market_segment="Online TA");

# Use of operator In

select y.adr from year2020 y
where adr in (37.8,48,35);

# Use of Between and Not Between operator

select y.reserved_room_type from year2020 y
where reserved_room_type between "D" and "G";

# Use of like 

select y.reserved_room_type from year2020 y
where reserved_room_type not between "D" and "G";

# Use of Aggregate functions- (Count, Min, Max, Avg and Sum)

select count(*) from year2018;

select count(Distinct country) from year2020;

select Min(adr) from year2018;

select max(adr) from year2018;

select avg(adr) from year2018;

select sum(adults) from year2018;

# Use of Like operator and wildcards

select y.market_segment from year2018 y
where market_segment like "D%";

select y.market_segment from year2018 y
where market_segment like "OF%";

select y.market_segment from year2018 y
where market_segment like "%e";

select y.stays_in_week_nights from year2020 y
where stays_in_week_nights like "%5";

select y.customer_type from year2020 y
where customer_type like "T%Y";

select y.country from year2020 y
where country like "_sp";

select y.country from year2020 y
where country like "__A";

select y.country from year2020 y
where country like "F_A%";

# Use of Limit and offset

select*from year2018
limit 5; 

select*from year2018
where meal="HB"
order by adr
limit 5; 

select*from year2018
where meal="HB"
order by adr
limit 2,5; 

# Use of the Subsets of Sql

# Use of Insert

insert into market_segments(Discount, market_segment)
values(2,"Aviation");

update meal
set meal="zero"
where cost= 0;

# Commit and Rollback

commit;

update meal
set meal="undefined"
where cost= 0;

Rollback;

# Delete with commit and rollback 

commit;

Delete from market_segments
where market_segment="groups";

rollback;

# Alter Table

alter table market_segments
add payment_amount varchar(255);

# modify

alter table market_segments
modify payment_amount varchar(255)
after discount;

# change Datatype of payment_mode 

alter table market_segments
modify payment_amount int(10);

# Add unique value to the payment_amount

alter table market_segments
add unique(payment_amount);

# change the column with datatype

alter table market_segments
change payment_amount payment varchar(255);


alter table market_segments
drop column payment;

# Rename the table

alter table market_segments
rename market;

# undo the rename command

alter table market
rename market_segments;

# IF and Case statement

select country,distribution_channel,adr,
if(adr>=50, "good", "average") as Performance
from  year2020;

select country,distribution_channel,adr,
case
 when adr>=70 and adr<=100 then "very good"
 when adr>=60 and adr<70 then "good"
 when adr>=50 and adr<60 then "average"
 when adr>=40 and adr<50 then "below average"
 when adr<40 then "bad"
 else "Incorrect adr"

 end as performance
 from year2020;
 
# View in the mysql

create view meal_market_segments
as
select country ,market_segment, cost
from year2020 y inner join meal m
on y.meal=m.meal;

select*from  meal_market_segments;














