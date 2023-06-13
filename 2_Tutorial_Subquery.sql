
						--employee(employee-name, street, city)
						--works(employee-name, company-name, salary)
						--company(company-name, city)
						--manages (employee-name, manager-name)

--(a) Find the names of all employees who work for First Bank Corporation.
	select employee_name From tbl_Works
	where company_name In (select company_name from tbl_Works where company_name = 'First Bank Corporation');

--(b) Find the names and cities of residence of all employees who work for Small Bank Corporation

	SELECT employee_name,city FROM tbl_Employee
	WHERE employee_name IN ( SELECT employee_name FROM tbl_Works WHERE company_name = 'Small Bank Corporation');

--(c)Find the names, street addresses, and cities of residence of all employees who work for First Bank Corporation and earn more than $10,000.

	SELECT employee_name,street,city FROM tbl_Employee
	WHERE employee_name in ( SELECT employee_name FROM tbl_Works WHERE salary > 85000 and company_name = 'Small Bank Corporation' );

--(d)Find all employees in the database who live in the same cities as the companies for which they work.	SELECT employee_name,city FROM tbl_Employee
	WHERE city in	(SELECT city FROM tbl_Company 
						where company_name in (select company_name from tbl_Works
							where tbl_Employee.employee_name = tbl_Works.employee_name));

--(e) Find all employees in the database who live in the same cities and on the same streets as do their managers.

	SELECT employee_name,city  FROM tbl_Employee e
	WHERE street IN ( SELECT m.street FROM tbl_Employee m, tbl_Manages mm 
						WHERE e.employee_name = mm.manager_name
							AND	m.employee_name = mm.manager_name
								AND m.street = e.street
									AND m.city = e.city);
	--Where is not allowing multiple comparisons like  where (street, address) in ...
	--(Problem here is that I don't know)	