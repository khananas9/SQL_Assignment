-- Creation of Tables--

create database Assignment;
use Assignment;

create table EmployeeTable(Employee_id int primary key,
First_name Varchar(20),Last_name Varchar(20),Salary float,
joining_date Datetime, Department varchar(20));

insert into EmployeeTable values(2,"Veena","Verma",80000,20110615090000,"Admin"),
(3,"Vishal","Singhal",300000,20200216090000,"HR"),
(4,"Sushanth","Singh",500000,20200217090000,"Admin"),
(5,"Bhupal","Bhati",500000,20110618090000,"Admin"),
(6,"Dheeraj","Diwan",200000,20110619090000,"Account"),
(7,"Karan","Kumar",75000,20200114090000,"Account"),
(8,"Chandrika","Chauhan",90000,20110415090000,"Admin");

select * from Employeetable;
use assignment;

create table employeeBonus(Employee_ref_id int,
Bonus_Amount float, Bonus_Date datetime ,
foreign key (Employee_ref_id) references EmployeeTable(Employee_id));

insert into EmployeeBonus values(1,5000,20200216000000),
(2,3000,20110616000000),(3,4000,20200216000000),
(1,4500,20200216000000),(2,3500,20110616000000);

create table Employee_Title(Employee_ref_id int,
Employee_title varchar (20), Affective_Date datetime);

insert into Employee_Title values(1,"Manager",20160220000000),
(2,"Executive",20160611000000),(8,"Executive",20160611000000),
(5,"Manager",20160611000000),(4,"Asst.Manager",20160611000000),
(7,"Executive",20160611000000),(6,"Lead",20160611000000),
(3,"Lead",20160611000000);

select * from employee_title;
select * from employeebonus;
select * from employeetable;

-- Questions--

-- 1 > Display the First_name and Last_name from EmployeeTable
-- into a single column as Full_name. A space charachter should 
-- Separeate them.

Select concat(First_name," ", Last_name) as Full_Name
from employeeTable;

-- 2 > Display details for Employees with the first name as
-- "Veena" and "Karan" from Employee Table.

select * from Employeetable where first_name = "Veena" or 
first_name = "Karan";

-- 3 > Display details of Employee with department name as "Admin".

select * from employeetable where department = 'Admin';

-- 4 > Display details of employees with Department name as 'Admin'.

select * from employeetable inner join employeebonus 
on employeetable.employee_id = employeebonus.employee_ref_id
where Bonus_amount between 3500 and 4500;

-- > Display the name of the employee who got the maximum bonus.

select * from employeetable inner join employeebonus 
on employeetable.employee_id = employeebonus.employee_ref_id
order by bonus_amount desc
limit 1;

-- > Display the average salary of each department

Select department , avg(Salary) 
from employeetable
group by department;

-- > Display the name of employees having the highest salary 
-- in each department

select employeetable.first_name, employeetable.last_name,employeetable.department,employeetable.salary
from employeetable
join (
select department,max(salary) as max_salary
from employeetable 
group by department) as max_salary
on employeetable.department = max_salary.department
and employeetable.salary = max_salary.max_salary;

-- > Display all departments alaong with the number of people in there

select Department,count(department) as strength
from employeetable group by department;

use assignment;

-- Display the departments that have less than 4 people in it.

select department,count(department) as strength from
employeetable group by department 
having strength < 4;

--  Display the second and third highst bonus with employee name
-- and department name from the table.

Select employeetable.first_name, employeetable.Last_name,
employeetable.department,employeebonus.bonus_amount
from employeetable inner join employeebonus
on employeetable.employee_id = employeebonus.employee_ref_id
order by bonus_amount desc
limit 2;

-- > Clone a new table from employee table

create table clone_employee as 
select * from employeetable;

select * from clone_employee;

-- > Delete employee from employee table whose salary are same

delete e1
from employeetable e1
join employeetable e2 on e1.salary = e2.salary and e1.employee_id <> e2.employee_id;

select * from employeetable;

-- > Display details of employee who get bonus more than
-- once and working as a manager

select employeetable.employee_id,employeetable.first_name,employeetable.last_name,
employeetable.department,employeebonus.bonus_amount,
employee_title.employee_title 
from employeetable
inner join employeebonus 
on employeetable.employee_id = employeebonus.employee_ref_id
inner join employee_title
on employeetable.employee_id = employee_title.employee_ref_id
where employee_title = 'Manager'
and employee_id in (select employee_ref_id
from employeebonus
group by employee_ref_id
having count(*) > 1);

-- > Assuming that the salary hike is 15% per annum.
-- > Display employee salary after 3 years who got bonus
-- > And Joined after 2014-01-01.

-- > Display employees details whose first name start with 
-- > S or last name ends with A

select * from employeetable where first_name like 'S%'
or last_name like '%A';

-- > Display employee title wise total salary

select employee_title.employee_title,sum(employeetable.salary) as Total_Salary
from employeetable
join employee_title
on employeetable.employee_id = employee_title.employee_ref_id
group by employee_title.employee_title;

-- > Hike employee salary by 10% who is working as a manager 
-- > and does not get bonus

update employeetable 
set employeetable.salary = employeetable.salary * 1.10
where employeetable.employee_id in (
select employee_title.employee_ref_id
from employee_title
left join employeebonus
on employee_title.employee_ref_id = employeebonus.employee_ref_id
where employee_title = "Manager"
and employeebonus.bonus_amount is null);

select * from employeetable;

















