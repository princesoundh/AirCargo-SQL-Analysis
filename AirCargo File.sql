create database AirCargo;
use AirCargo;

select *
from passengers_on_flights
where route_id between 1 and 25;

select
sum(no_of_tickets) as total_passengers,
sum(no_of_tickets * Price_per_ticket) as total_revenue
from ticket_details
where class_id = 'Business';

select 
customer_id,
concat(first_name, ' ', last_name) AS full_name
from customer;

select distinct
customer.customer_id,
customer.first_name,
customer.last_name
from customer
inner join ticket_details
on customer.customer_id = ticket_details.customer_id;

select distinct
customer.customer_id,
customer.first_name,
customer.last_name
from ticket_details
join customer
on ticket_details.customer_id = customer.customer_id
where ticket_details.brand = "Emirates";

select*
from customer
where customer_id in(
select distinct customer_id
from passengers_on_flights
where class_id = "Economy Plus");

select
sum(no_of_tickets * price_per_ticket) as total_revenue,
if(sum(no_of_tickets * price_per_ticket) > 10000,
"revenue has crossed 10000",
"revenue has not crossed 10000") as revenue_status
from ticket_details;

create user 'Newuser'@'NewHost' identified by 'WeakP@ss321';
grant all privileges
on AirCargo.*
to 'Newuser'@'NewHost';
flush privileges;

select distinct
class_id,
max(price_per_ticket) over (partition by class_id) as max_price_per_class
from ticket_details;

create index idx_route_id
on passengers_on_flights(route_id);

select*
from passengers_on_flights
where route_id = 4;

select
customer_id,
aircraft_id,
sum(no_of_tickets * price_per_ticket) as total_amount
from ticket_details
group by customer_id, aircraft_id with rollup;

create view business_class_customers as
select distinct
ticket_details.customer_id,
customer.first_name,
customer.last_name,
ticket_details.brand
from ticket_details
join customer
on ticket_details.customer_id = customer.customer_id
where ticket_details.class_id = "Business";

select*
from business_class_customers

delimiter //
create procedure Get_Long_Routes()
begin
select* 
from routes
where distance_miles > 2000;
end //
delimiter ;

call Get_Long_Routes();

select
customer_id,
sum(no_of_tickets) as total_tickets,
sum(no_of_tickets * price_per_ticket) as total_amount_paid
from ticket_details
group by customer_id;

select
count(*) / count(distinct route_id) as avg_passengers_per_route
from passengers_on_flights;