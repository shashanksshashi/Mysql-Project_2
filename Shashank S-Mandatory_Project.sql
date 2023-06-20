-- 1) Calculate average Unit Price for each CustomerId.

select c.customerid,
	   avg(unitprice) over(partition by c.CustomerID) Avg_unit_price
from customers c 
inner join orders o on c.CustomerID=o.CustomerID
inner join order_details det on det.OrderID=o.OrderID;        


-- 2) Calculate average Unit Price for each group of CustomerId AND EmployeeId.

select c.customerid,o.EmployeeID,
	   avg(unitprice) over(partition by c.CustomerID,o.EmployeeID) Avg_unit_price
from customers c 
inner join orders o on c.CustomerID=o.CustomerID
inner join order_details det on det.OrderID=o.OrderID;



-- 3) Rank Unit Price in descending order for each CustomerId.

select customerid,
	   dense_rank()over(order by unitprice desc) Rank_of_unitprice
from order_details dets 
inner join orders o on dets.OrderID=o.OrderID; 


-- 4) How can you pull the previous order date’s Quantity for each ProductId.

select p.productid,orderdate,quantity,
       lag(orderdate,1)over(partition by p.productid) Previous_date
from products p 
inner join order_details dets on p.ProductID=dets.ProductID
inner join orders o on dets.OrderID=o.OrderID;       
 
 
-- 5) How can you pull the following order date’s Quantity for each ProductId.

select p.productid,orderdate,quantity,
       lead(orderdate,1)over(partition by p.productid) Following_date
from products p 
inner join order_details dets on p.ProductID=dets.ProductID
inner join orders o on dets.OrderID=o.OrderID; 


-- 6) Pull out the very first Quantity ever ordered for each ProductId.

select productid,
       first_value(OrderID) over(partition by productid) First_ordered_quantity
from order_details;

-- 7) Calculate a cumulative moving average UnitPrice for each CustomerId.

select c.customerid,
	   avg(unitprice) over (partition by c.CustomerID)Average_unit_price,
       row_number()   over(order by unitprice) Row_numbers,
       cume_dist()    over(order by UnitPrice) Cumulative_unit_price
from customers c 
inner join orders o on c.CustomerID=o.CustomerID
inner join order_details det on det.OrderID=o.OrderID;




-- " Theoritical Questions ".

-- 1) Can you define a trigger that is invoked automatically before a new row is inserted into a table?

-- A trigger is that which is fired when an insert,update (or) delete statement is executed on a table,
-- In the above situation a trigger is fired automatically before any insert done to the particular tabe.
-- For example : If we consider a table with employeeid and his city and a before trigger is created on this table so that
--               whenever the city is not DELHI it must show an error (or) show a particular message.
--               So, If we try to insert a new city into table which is not delhi it won't accept and that is the purpose of TRIGGER.  
  

-- 2) What are the different types of triggers?
-- There are bascically 2 types of trigger ,
--    "DML TRIGGERS"
  --   AFTER UPDATE, BEFORE UPDATE
  --   AFTER INSERT, BEFORE INSERT
  --   AFTER DELETE, BEFORE DELETE
--    "DDL TRIGGERS"  
--    Data Definition Language (DDL) triggers are, like DML triggers.In this case, it's fired by a DDL event which mostly 
--    corresponds to a statement like CREATE, ALTER, DROP, REVOKE, UPDATE STATISTICS being executed.

   
-- 3) How is Metadata expressed and structured?
      -- Metadata is data about data, and it is the description and context of the data
      -- It holds information about:tables,columns,data types,table relationship,constraints etc.
      -- Metadata refers to name of attributes, their types, user constraints, integrity information and storage information.
      -- INFORMATION_SCHEMA provides access to database metadata,information about the MySQL server such as 
          -- the name of a database or table, the data type of a column, or access privileges.


-- 4) Explain RDS and AWS key management services.
-- " RDS(RELATIONAL DATABASE SERVICES)"
   -- Amazon Relational Database Service (RDS) is a managed SQL database service provided by Amazon Web Services (AWS). 
   -- Amazon RDS supports an array of database engines to store and organize data. 
   -- It also helps with relational database management tasks, such as data migration, backup, recovery and patching.
   -- It provides affordable relational databases in the cloud, that is easy to use.

-- " AWS KEY MANAGEMENT SERVICES "
   -- AWS provides over a hundred plus services which include storage, networking, database, application services, and many more.
     -- Out of these services,  AWS KMS Key Management Service is a useful and very beneficial 
	 -- service while dealing with sensitive data and it also makes it easy for us to create and manage cryptographic keys.
   -- AWS Key Management Service provides a highly available key storage, management, and auditing solution for us to encrypt data
     -- within our own applications and control the encryption of stored data across AWS services. 



-- 5) What is the difference between amazon EC2 and RDS?
  -- " EC2 (ELASTIC COUMPUTE ClOUD)"
       -- EC2 is service provided by AWS which Provides secure and resizeable compute capacity in cloud.
       -- It provides scalable computing capacity. It enables us to scale up and down according to the changes in requirements.
      
  -- "RDS (RELATIONAL DATABASE SERVICES) " 
       -- Relational Database Service (Amazon RDS) is a collection of managed services that
          -- makes it simple to set up, operate, and scale databases in the cloud.
  -- a) AVAILIBILITY
      -- Amazon RDS is a highly available relational database
      -- EC2 instance, we have to set up MySQL for high availability
      
  -- b) SCAlIBILITY
     -- Scaling up our database is comparatively easier with Amazon RDS when compared to EC2
     
  -- c) SECURITY
     -- EC2's main priority is to provide security to the users 


