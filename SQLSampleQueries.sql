---Using the particular database
Use Practice

---Creating new database--
create database RakeshPractice 

--creating table with NotNull constraint-----
create table employee1 (eid int Not Null,ename varchar(100),elocation varchar(100))
--Creating table with Unique and identity Constraint----
create table employee2 (eid int identity(1,1),ename varchar(100)unique,elocation varchar(100))

----Inserting values into table------
insert into employee1 values(1,'Rakesh','HYD2'),(2,'Ravi','HYD2'),(3,'Vikram','HYD1'),(4,'Prathyusha','HYD1'),(5,'Raj','HYD2'),(6,'Rajesh','HYD2')

insert into employee2 values('Rakesh','HYD2'),('Ravi','HYD2'),('Vikram','HYD1'),('Prathyusha','HYD1'),('Raj','HYD2'),('Rajesh','HYD2'),('Praveena','HYD1'),('Kiran','HYD1')
select * from employee1



select * from employee2

---Selecting the table data using Set Operators--------
select * from employee1 UNION select * from employee2

select * from employee1 UNION ALL select * from employee2

select * from employee1 INTERSECT select * from employee2

select * from employee2 EXCEPT  select * from employee1

select * from employee1
select * from employee2



----Creating table with Primary key constraint------
create table employee3 (eid int Primary key,ename varchar(100),esalary varchar(100))
create table join1(jid int Primary key ,jname varchar(100),jlocation varchar(100),jsupid int)

---Creating table with Foreign key constraint-----
create table employee4 (eid int foreign key references employee3(eid),ename varchar(100),elocation varchar(100) default 'HYD2')
create table join2(jid int Foreign key references join1(jid),orderdetails varchar(100),orderid int)

----After creating the table then making one column value to default value----
alter table <tablename> alter column elocation default 'HYD1'

----Check constraint------
create table employee5 (eid int check (eid>0),ename varchar (100),elocation varchar(100))

---Selecting the data in a table with LIKE operator and Comparision operators----
select * from employee1 where ename like '%[^HA]'
select * from employee2 where ename like 'ra%'
select * from employee3 where ename IN('rakesh','ravi')
select * from employee4 where elocation is null
select * from employee3 where esalary between '10000' and '30000'

----Adding Unique constraint-----
alter table employee5 add constraint uq_ename unique(ename,eid)

select * from join2
insert into join1 values (1,'Vijay','hyd3',2),(2,'Rohit','HYD1',NULL),(3,'Khaleel','HYD3',1),(4,'Ananth','HYD1',3)



-----Applying Joins---------
select * from employee1 left join employee2 on employee1.ename=employee2.ename
select * from employee1 right join employee2 on employee1.ename=employee2.ename
select * from employee1 full outer join employee2 on employee1.ename=employee2.ename

select * from join1 j1 INNER JOIN join2 j2 on j1.jid = j2.jid 

select * from join1 j1 LEFT JOIN join2 j2 on j1.jid = j2.jid 

select * from join1 j1 RIGHT JOIN join2 j2 on j1.jid = j2.jid 

select * from join1 j1 FULL OUTER JOIN join2 j2 on j1.jid = j2.jid 

select j1.jname as supervisorname ,j2.jname from join1 j1 ,join1 j2 where j1.jsupid=j2.jid  ----self join

------Deleting the table-----
delete from Table2_ECD where Name='Rakesh'

-----Truncating the table------
Truncate table Table2_ECD where Name='Rakesh'

-----GroupBy related queries------
create table group1 (gid int identity(1,1),gname varchar(100),ggroup varchar(50),gsalary varchar(20))

insert into group1 values ('Rakesh','HYD2','25000'),('Vikram','HYD1','20000'),('Raj','HYD2','30000'),('Nitish','HYD1','30000'),('Ravi','HYD2','35000')

select * from group1 

select ggroup,gid,count(*) as number_of_employees from group1 group by ggroup,gid 
having COUNT(*)>0 and gid>1

----Creating View and writing queries on view--------------
create view view1 As 
(select * from employee1 where elocation ='HYD2')

select * from view1
select * from employee1
insert into employee1 values(7,'Nitish','HYD1'),(8,'Praveena','HYD1'),(9,'Sudhir','HYD2')
insert into view1 values(10,'Varaprasad','HYD2'),(11,'Kartheek','HYD1'),(12,'Kiran','HYD1')
update employee1 set elocation='HYD2' where eid=7
update view1 set elocation='HYD1' where eid=10

delete from view1

drop view view1
truncate --we cannot do on views 


-----Using Begin,Rollback,commit transactions------
begin Transaction
delete from Master where DRUG_ID=11916

commit
rollback
----------------







