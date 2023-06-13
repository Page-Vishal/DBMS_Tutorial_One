SELECT * FROM tbl_Employee;
SELECT * FROM tbl_Works;
SELECT * FROM tbl_Manages;

	--employee(employee-name, street, city)
	--works(employee-name, company-name, salary)
	--company(company-name, city)
	--manages (employee-name, manager-name)


--(f) Find ALL employees in the database who do not work for First Bank Corporation.

		SELECT employee_name,company_name FROM tbl_Works
		WHERE NOT company_name = 'First Bank Corporation';

--(g) Find ALL employees in the database who earn more than each employee of SmALL Bank Corporation.

		SELECT employee_name, salary AS Employee FROM tbl_Works
		WHERE salary > (SELECT MAX(salary) FROM tbl_Works WHERE company_name = 'SmALL Bank Corporation');

		SELECT employee_name FROM tbl_Works
		where salary > ALL(SELECT salary FROM tbl_Works
			where company_name = 'SmALL Bank Corporation');

--(h) AsSUMe that the companies may be located in several cities. Find ALL companies located in every city 
-- in which SmALL Bank Corporation is located

			SELECT * FROM tbl_Company 
			WHERE city = (SELECT city FROM tbl_Company WHERE company_name = 'SmALL Bank Corporation');

--(i) Find ALL employees who earn more than the average salary of ALL employees of their company

		SELECT employee_name,emp.company_name,salary FROM tbl_Works emp
		INNER JOIN (SELECT company_name, AVG(salary) as AVGSalary FROM tbl_Works GROUP BY company_name ) company_AVG
		on emp.company_name = company_AVG.company_name and emp.salary >= company_AVG.AVGSalary;

--(j) Find the company that has the most employees.

		SELECT TOP 1 company_name, COUNT(employee_name) countz FROM tbl_Works
		GROUP BY company_name
		ORDER BY countz DESC;

		SELECT company_name,count(employee_name) as Employees FROM tbl_Works
		GROUP BY company_name
		HAVING count(employee_name) in
		(SELECT MAX(c_e) FROM (SELECT company_name, count(employee_name) AS c_e FROM tbl_Works w GROUP BY company_name) subquery)

		SELECT company_name FROM tbl_Works
		GROUP BY company_name
		HAVING count (employee_name) >= ALL (SELECT count (employee_name) FROM tbl_Works GROUP BY company_name)

--(k) Find the company that has the smALLest payroll.

		SELECT company_name Comapny, salary Payroll FROM tbl_Works
		WHERE salary IN (SELECT MIN(salary) FROM tbl_Works);

		--This deals with the minimum of average salary a company gives to its employee
		SELECT company_name FROM tbl_Works
		WHERE salary in
		(SELECT MIN(AVG_salary) AS min_AVG_salary 
		FROM (SELECT company_name,AVG(salary) AS AVG_salary FROM tbl_Works w GROUP BY company_name) subquery)

		--This deals with payroll i.e total amount paid by the company
		SELECT company_name FROM tbl_Works
		GROUP BY company_name
		HAVING SUM (salary) <= ALL (SELECT SUM (salary) FROM tbl_Works GROUP BY company_name);

--(l) Find those companies whose employees earn a higher salary, on average, than the average salary at First Bank Corporation.		SELECT employee_name,company_name FROM tbl_Works
		WHERE salary > (SELECT AVG(SALARY) FROM tbl_Works WHERE company_name='First Bank Corporation');

		SELECT company_name FROM tbl_Works
		GROUP BY company_name
		HAVING AVG(salary) > (SELECT AVG(salary) FROM tbl_Works WHERE company_name = 'First Bank Corporation');
