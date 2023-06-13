SELECT * FROM tbl_Employee;
SELECT * FROM tbl_Manages;
SELECT * FROM tbl_Works;
SELECT * FROM tbl_Company;
SELECT * FROM tbl_Manages;
						--works(employee-name, company-name, salary)
						--company(company-name, city)
						--manages (employee-name, manager-name)
	WHERE company_name = 'First Bank Corporation';

--(b) Find the names and cities of residence of all employees who work for Small Bank Corporation
	
	SELECT tbl_Employee.employee_name, city FROM tbl_Employee, tbl_Works
	where tbl_Employee.employee_name = tbl_Works.employee_name AND company_name = 'Small Bank Corporation';

--(c) Find the names, street addresses, and cities of residence of all employees who work for Small Bank Corporation and earn more than $10,000.

	SELECT e.employee_name , e.street, e.city
	FROM tbl_Employee e,tbl_Works w
	WHERE e.employee_name = w.employee_name
	AND w.company_name = 'Small Bank Corporation'
	AND w.salary > 10000;

--(d) Find all employees in the database who live in the same cities as the companies for which they work.