--SQL Joins

/*
 *Supported JOINS in Clickhouse
 *
 *-Inner 
 *-Left
 *-Right
 *-Full
 *-Cross
 */

create database joins_example;

create table joins_example.customers(
	customer_id String,
	name String,
	city String,
	birth_year String)
	ENGINE = MergeTree()
	PRIMARY KEY customer_id
	ORDER BY tuple(customer_id);

create table joins_example.orders(
	order_id String,
	customer_id String,
	quantity UInt64,
	bill_amount Float64)
    ENGINE = MergeTree()
	PRIMARY KEY customer_id
	ORDER BY tuple(customer_id);


insert into joins_example.customers values 
('1a','Chloe','Manchester','1982'),
('1b','Richard','Leeds','1996'),
('1c','Emily','London','1963'),
('1d','William','Bristol','1974'),
('1e','Henry','Leeds','1992'),
('1f','Philip','Liverpool','1987'),
('1g','Lisa','Southampton','1979'),
('2a','Stephen','Norwich','1979');


insert into joins_example.orders values 
('a21','1a',7,35.87),
('a21','1a',105,852.77),
('a31','1b',12,65.85),
('a27','1c',45,352.68),
('a22','1d',87,687.52),
('b21','1e',72,602.32),
('g71','1g',32,258.69),
('h22','1g',23,212.74),
('q87','1h',49,423.12),
('q87','1i',55,487.25),
('q87','1j',68,521.15)


/**
 * INNER JOIN
 * 
 * from both tables 
 */

select orders.order_id ,orders.quantity ,customers.name, customers.birth_year
from joins_example.orders orders
inner join joins_example.customers customers
on orders.customer_id = customers.customer_id ;

/**
 * LEFT JOIN
 * 
 * all from left tables but only matched from right with nulls 
 */

select orders.order_id, orders.quantity, customers.name, customers.birth_year
from joins_example.orders as orders
left join joins_example.customers as customers
on orders.customer_id = customers.customer_id ;

/**
 * RIGHT JOIN
 * 
 * all from right tables but only matched from left with nulls
 */

select orders.order_id, orders.quantity, customers.name, customers.birth_year
from joins_example.orders as orders
right join joins_example.customers as customers
on orders.customer_id = customers.customer_id ;

/**
 * FULL JOIN
 * all from right and left tables even if not matched
 * */

select orders.order_id, orders.quantity, customers.name, customers.birth_year
from joins_example.orders as orders
full join joins_example.customers as customers
on orders.customer_id = customers.customer_id ;

/*
 * CROSS JOIN
 * 
 * cartesian product matches rows on left to rows on right
 */

select *
from joins_example.orders as orders
cross join joins_example.customers as customers;

/**
 * UNION 
 * Clickhouse has UNION ALL clause , which can be
 * used to combine the result set from multiple 
 * SELECT statements.Regular UNION whicb returns 
 * distinct values is not directly supported but 
 * can be implemented using DISTINCT
 * 
 * the columns in the select statements must be of 
 * -the same number
 * -same data type
 * -same order
 */

SELECT order_id as id FROM joins_example.orders 
UNION ALL
SELECT customer_id as id FROM joins_example.customers;



