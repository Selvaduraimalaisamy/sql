create table Employees1(id int primary key,first_name varchar (40) ,last_name varchar (40),salary decimal(8,2),department_id int,year_of_joining datetime,year_of_relieving datetime)
insert into Employees1 values(1,'selva','durai',13500,1,'12-05-2020','12-05-2021')
insert into Employees1 values(2,'rahul','dharsan',14500,2,'03-06-2020','12-05-2022')
insert into Employees1 values(3,'deva','sena',15500,3,'09-09-2021','11-09-2022')
insert into Employees1 values(4,'dharun','priyan',13900,4,'11-05-2019','02-05-2020')
insert into Employees1 values(5,'nithin','priyan',19500,5,'01-10-2016','01-05-2022')
insert into Employees1 values(6,'muthu','murugan',16500,1,'03-16-2011','02-08-2018')
insert into Employees1 values(7,'senbaha','surya',15500,2,'05-22-2012','11-13-2019')
insert into Employees1 values(8,'nivas','kannan',13500,3,'02-21-2019','11-10-2022')
insert into Employees1 values(9,'vijaya','rahavan',22500,4,'01-01-2020','09-19-2022')
insert into Employees1 values(10,'bala','murugan',20500,5,'09-08-2013','10-29-2014')
select * from Employees1
alter table Employees1,SELVA_EMPLOYEES;
sp_rename'Employees1','SELVA_EMPLOYEES';
select * from SELVA_EMPLOYEES;
create table departments1(department_id int primary key,manager_id int,department_name varchar(50))
insert into departments1 values(1,100,'mech')
insert into departments1 values(2,111,'ece')
insert into departments1 values(3,222,'eee')
insert into departments1 values(4,333,'civil')
insert into departments1 values(5,444,'e&i')
select * from departments1
sp_rename'departments1','SELVA_DEPARTMENTS';
select * from SELVA_DEPARTMENTS;
/*1*/
select first_name,last_name from SELVA_EMPLOYEES where first_name like 's%';
/*2*/
select first_name,last_name from SELVA_EMPLOYEES where first_name like 's%' or  last_name like '%n';
/*3*/
select first_name,last_name from SELVA_EMPLOYEES where department_id=2 and first_name like 's%';
/*4*/
select department_id from SELVA_EMPLOYEES where department_id like '_2%';
/*5*/
select * from SELVA_EMPLOYEES where department_id in (1,2,5); 
/*6*/
select * from SELVA_EMPLOYEES where salary between 15000 and 20000; 
/*7*/
select first_name,salary,SELVA_EMPLOYEES.department_id,manager_id from SELVA_EMPLOYEES inner join SELVA_DEPARTMENTS on SELVA_EMPLOYEES.department_id=SELVA_DEPARTMENTS.department_id where manager_id is null;
/*8*/
select * from SELVA_EMPLOYEES order by first_name asc;
/*9*/
select first_name,department_id,salary from SELVA_EMPLOYEES order by department_id asc , salary desc; 
/*10*/
select left (first_name,3)from SELVA_EMPLOYEES ;
/*11*/
select right (last_name,2) from SELVA_EMPLOYEES;
/*12*/
select  first_name ,charindex('a',first_name) as position from SELVA_EMPLOYEES;
/*13*/
select max (salary) as MAXIMUM_SALARY from SELVA_EMPLOYEES;
/*14*/
select max (salary)as MAXIMUM_SALARY from SELVA_EMPLOYEES where salary < (select max (salary) from SELVA_EMPLOYEES);
/*15*/
select avg (salary) as AVERAGE_SALARY from SELVA_EMPLOYEES where department_id=3;
/*16*/
select first_name, year( year_of_joining) from SELVA_EMPLOYEES where department_id=3;
/*17*/
select avg(salary)as AVERAGE_SALARY from SELVA_EMPLOYEES where year_of_relieving < GETDATE();
/*18*/
select month(year_of_joining)as month_of_joining from SELVA_EMPLOYEES group by month(year_of_joining) having count(id)>5;
/*19*/
select last_name,year_of_joining from SELVA_EMPLOYEES where year_of_joining between '01-01-2014' and '12-31-2020';
/*20*/
select year(year_of_joining) from SELVA_EMPLOYEES group by year(year_of_joining) having count(id)>10;
/*21*/
select department_name from SELVA_EMPLOYEES inner join SELVA_DEPARTMENTS on SELVA_EMPLOYEES.department_id=SELVA_DEPARTMENTS.department_id group by department_name having avg(salary)>10000;
/*22*/
select datediff(day,year_of_joining,year_of_relieving)as Working_days from SELVA_EMPLOYEES ; 
/*23*/
select * from SELVA_EMPLOYEES where year_of_joining=getdate();
/*24*/
select upper(first_name),lower(last_name) from SELVA_EMPLOYEES;
/*25*/
select len(first_name)from SELVA_EMPLOYEES where last_name like'___%b%';
/*26*/
select first_name ,year(year_of_relieving)-year(year_of_joining) experience from SELVA_EMPLOYEES;
/*27*/
select first_name from SELVA_EMPLOYEES where datename(month,year_of_joining)='May' ;
/*28*/
select id,first_name,last_name from SELVA_EMPLOYEES where salary > (select avg(salary) from SELVA_EMPLOYEES); 
/*29*/
create table SELVA_EMPLOYEES(id int primary key,first_name varchar (40) ,last_name varchar (40),salary decimal(8,2),department_id int,year_of_joining datetime,year_of_relieving datetime)
create table  SELVA_DEPART(department_id int primary key foreign key references SELVA_EMPLOYEES(id),manager_id int,department_name varchar(50))
/*30*/
update SELVA_EMPLOYEES set first_name='AAA' where first_name is null;
/*31*/
create view SELVA_EMP as select id,first_name,last_name,s.department_id,department_name from SELVA_EMPLOYEES as s inner join SELVA_DEPARTMENTS as r on s.department_id=r.department_id;
select * from SELVA_EMP;

/*32*/
create synonym selva_sys for SELVA_EMPLOYEES;
sp_rename 'selva_sys','SELVA_SYS';
select * from SELVA_SYS ;

/*33*/
create procedure DATES
as
select id from SELVA_EMPLOYEES where year_of_joining  between '01-01-2015' and '12-31-2018'
go
exec DATES;
/*34*/
create procedure insert_row
as
insert into SELVA_DEPARTMENTS values(6,666,'mech')
go
sp_rename 'insert_row','INSERTING_ROWS';
exec INSERTING_ROWS;
select * from SELVA_DEPARTMENTS;
/*35*/
select replace(convert(varchar,'2006-12-30',101),'-','')+ replace(convert(varchar,'00:38:54',108),':','');