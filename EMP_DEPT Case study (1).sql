
/* Question 2*/

create table dept(deptno int primary key ,dname varchar(30),loc varchar(30));
insert into dept values(10,'OPERATIONS','BOSTON'),(20,'RESEARCH','DALLAS'),(30,'SALES','CHICAGO'),(40,'ACCOUNTING','NEWYORK');

drop table dept;

select * from dept;


drop table employee;

/* Question 1*/

create table employee(empno int primary key,ename varchar(50),job varchar(50) default 'CLERK',mgr int,hiredate date,sal int check(sal>0), comm int,deptno int ,foreign key(deptno) references dept(deptno) on delete cascade on update cascade );

select * from employee;
describe employee;

insert into employee values(7369,'SMITH','CLERK',7902,'1890-12-17',800,NULL,20);
insert into employee values(7499,'ALLEN','SALESMAN',7698,'1981-02-20',1600,300,30),(7521,'WARD','SALESMAN',7698,'1981-02-22',1250,500,30),(7566,'JONES','MANAGER',7839,'1981-04-02',2975,NULL,20),(7654,'MARTIN','SALESMAN',7698,'1981-09-28',1250,1400,30),(7698,'BLAKE','MANAGER',7839,'1981-05-01',2850,NULL,30),(7782,'CLARK','MANAGER',7839,'1981-06-09',2450,NULL,10),(7788,'SCOTT','ANALYST',7566,'1987-04-19',3000,NULL,20),(7839,'KING','PRESIDENT',NULL,'1981-11-17',5000,NULL,10),(7844,'TURNER','SALESMAN',7698,'1981-09-08',1500,0,30),(7876,'ADAMS','CLERK',7788,'1987-05-23',1100,NULL,20),(7900,'JAMES','CLERK',7698,'1981-12-03',950,NULL,30),(7902,'FORD','ANALYST',7566,'1981-12-03',3000,NULL,20),(7934,'MILLER','CLERK',7782,'1982-01-23',1300,NULL,10);


/* Question 3:	List the Names and salary of the employee whose salary is greater than 1000*/

select ename,sal from employee where sal>1000;


/* Question 4: List the details of the employees who have joined before end of September 81*/

select * from employee where hiredate<'1981-09-30';

/*Question 5: 	List Employee Names having I as second character.*/

select ename from employee where ename like '_I%';


/*Question 6:List Employee Name, Salary, Allowances (40% of Sal), P.F. (10 % of Sal) and Net Salary. Also assign the alias name for the columns */

select ename ,sal,sal*0.40 as allowances,sal*0.10 as pf,sal+(sal*0.40)+(sal*0*10) as netsalary from employee;


/*Question 7: List Employee Names with designations who does not report to anybody*/

select ename,job from employee where mgr is null;

/* Question 8: List Empno, Ename and Salary in the ascending order of salary */

select empno,ename,sal from employee order by sal asc;

/* Question 9: How many jobs are available in the Organization ?*/

select count( distinct job) from employee;

/* Question 10: Determine total payable salary of salesman category */

select sum(sal) from employee where job like 'SALESMAN';

/* Question 11: List average monthly salary for each job within each department  */

select deptno,job,avg(sal) from employee group by deptno,job;

/* Question 12:	Use the Same EMP and DEPT table used in the Case study to Display EMPNAME, SALARY and DEPTNAME in which the employee is working */

select ename,sal,dname from employee left join dept on employee.deptno=dept.deptno;

/* Question 13:Create the Job Grades Table */

create table jobgrades(grade varchar(2),lowest_sal int,highest_sal int);

select * from jobgrades;

insert into jobgrades values('A',0,999),('B',1000,1999),('C',2000,2999),('D',3000,3999),('E',4000,5000);

/* Question 14:Display the last name, salary and  Corresponding Grade.*/

SELECT ename,sal,grade FROM employee, jobgrades WHERE sal BETWEEN lowest_sal AND highest_sal;

/* Question 15:Display the Emp name and the Manager name under whom the Employee works in the below format  "Emp Report to MgrEmp Report to Mgr"*/

select 
  employee.ename as "Employee", 
  employee.empno as "Empno", 
  employee.mgr as "Mgrno",
  m.ename as "Manager"
from 
 employee
  LEFT OUTER JOIN employee m ON
   employee.mgr = m.empno;






/* Question 16: Display Empname and Total sal where Total Sal (sal + Comm)*/

select ename, COALESCE(sal, 0) + COALESCE(comm, 0 ) as totalsalary from employee;

/* Question 17:Display Empname and Sal whose empno is a odd number*/

select ename,sal from employee where mod(empno,2) <> 0;

/* Question 18: Display Empname , Rank of sal in Organisation , Rank of Sal in their department */

select deptno,ename,sal,dense_rank() over (partition by deptno order by sal desc ) as rank_dept,dense_rank() over (order by sal desc) as rank_org from employee ;


/* Question 19: Display Top 3 Empnames based on their Salary */

select ename,sal from employee order by sal desc limit 3;


/* Question 20: Display Empname who has highest Salary in Each Department.*/

SELECT deptno, ename, sal FROM employee  WHERE (deptno,sal) IN (SELECT deptno, MAX(sal) FROM employee GROUP BY deptno) order by deptno;












