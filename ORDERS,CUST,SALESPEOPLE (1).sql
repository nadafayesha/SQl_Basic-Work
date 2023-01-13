/* Question 1 */

create table salespeople(snum int,sname varchar(50),city varchar(50),comm float8);
select * from salespeople;

insert into salespeople values(1001,'Peel','London',0.12),(1002,'Serres','San Jose',0.13),(1003,'Axelrod','New york',0.10),(1004,'Motika','London',0.11),(1007,'Rafkin','Barcelona',0.15);

/* Question 2 */

create table cust(cnum int,cname varchar(50),city varchar(50),rating int,snum int);

insert into cust values(2001,'Hoffman','London',100,1001),(2002,'Glovanne','Rome',200,1003),(2003,'Liu','San Jose',300,1002),(2004,'Grass','Berlin',100,1002),(2006,'Clemens','London',300,1007),(2007,'Pereira','Rome',100,1004),(2008,'James','London',200,1007);

select * from cust;

/* Question 3 */

create table orders (onum int,amt float,odate date,cnum int,snum int);

insert into orders values(3001,18.69,'1994-10-03',2008,1007),(3002,1900.10,'1994-10-03',2007,1004),(3003,767.19,'1994-10-03',2001,1001),(3005,5160.45,'1994-10-03',2003,1002),(3006,1098.16,'1994-10-04',2008,1007),(3007,75.75,'1994-10-05',2004,1002),(3008,4723.00,'1994-10-05',2006,1001),(3009,1713.23,'1994-10-04',2002,1003),(3010,1309.95,'1994-10-06',2004,1002),(3011,9891.88,'1994-10-06',2006,1001);

select * from orders;


/* Question 4: Write a query to match the salespeople to the customers according to the city they are living.*/

select salespeople.city,salespeople.snum,salespeople.sname,salespeople.comm,cust.cnum ,cust.cname from salespeople inner join cust on salespeople.city=cust.city;



/*Question 5:Write a query to select the names of customers and the salespersons who are providing service to them.*/


select cname,sname from cust inner join salespeople on cust.snum=salespeople.snum;


/* Question 6: Write a query to find out all orders by customers not located in the same cities as that of their salespeople */


SELECT onum,amt,odate,cust.city as customer_city,salespeople.city as salesperson_city from  orders,cust,salespeople WHERE cust.city <> salespeople.city AND orders.cnum = cust.cnum AND orders.snum = salespeople.snum order by onum asc;


/* Question 7:Write a query that lists each order number followed by name of customer who made that order */

select onum,cname from orders inner join cust on orders.cnum=cust.cnum;

/* Question 8: Write a query that finds all pairs of customers having the same rating */

select rating,cname from cust order by rating;

/* Question 9: Write a query to find out all pairs of customers served by a single salesperson */

Select cname from cust where snum in (select snum from cust group by snum having count(snum) = 1);


/* Question 10: Write a query that produces all pairs of salespeople who are living in same city*/

select city,snum,sname ,comm from salespeople where city in (select city from salespeople group by city having count(city) >1);

/* Question 11: Write a Query to find all orders credited to the same salesperson who services Customer 2008 */

select * from orders where snum in (select snum from cust where cnum =2008);

/* Question 12:Write a Query to find out all orders that are greater than the average for Oct 4th */

select * from orders where amt > ( select avg(amt) from orders where odate = '1994-10-04');

/* Question 13: Write a Query to find all orders attributed to salespeople in London*/

select * from orders where snum in (select snum from salespeople where city ='London');

/* Question 14: Write a query to find all the customers whose cnum is 1000 above the snum of Serres. */

select * from cust where cnum = 1000+ (select snum from salespeople where sname ='Serres');

/* Question 15: Write a query to count customers with ratings above San Jose’s average rating */

select count(cnum) from cust where rating > (select avg(rating) from cust where city='San Jose');

/* Question 16: Write a query to show each salesperson with multiple customers */


SELECT * FROM salespeople WHERE snum IN (SELECT DISTINCT snum FROM cust a WHERE EXISTS (SELECT * FROM cust b WHERE b.snum=a.snum AND b.cname<>a.cname));














