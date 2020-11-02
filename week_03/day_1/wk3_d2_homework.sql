--MVP 
--Q1 Find all the employees who work in the ‘Human Resources’ department.
SELECT *
FROM employees 
WHERE department ='Human Resources';

--Q2 Get the first_name, last_name, and country of the employees who work in the ‘Legal’ department.

SELECT
	first_name,
	last_name,
	country
FROM employees 
WHERE department = 'Legal'

--Q3 Count the number of employees based in Portugal.

SELECT 
	COUNT(id) AS number_of_employees_in_portgual
FROM employees 
WHERE country = 'Portugal'

--Q4 Count the number of employees based in either Portugal or Spain.

SELECT 
 	COUNT(id) AS number_of_employees_in_spain_and_potugual
 FROM employees 
 WHERE country = 'Spain' OR country = 'Portugal'
 
 --Q5 Count the number of pay_details records lacking a local_account_no.
 
 SELECT *
 FROM pay_details 
 
 SELECT 
 	COUNT(id) AS number_of_people_without_local_account
 FROM pay_details 
 WHERE local_account_no IS NULL
 
-- Q6 Get a table with employees first_name and last_name ordered alphabetically by last_name (put any NULLs last).

 SELECT 
 	first_name,
 	last_name
 FROM employees 
 ORDER BY last_name ASC NULLS LAST
 
 --Q7 How many employees have a first_name beginning with ‘F’?
 
 SELECT 
 	COUNT(id) AS number_of_people_with_first_name_begining_with_f
FROM employees 
WHERE first_name LIKE 'F%'

--Q8 Count the number of pension enrolled employees not based in either France or Germany.

SELECT 
	COUNT(id) AS number_of_people_on_pension_not_based_in_FRA_or_ger
FROM employees
WHERE (pension_enrol = TRUE) AND (country != 'France' OR country != 'Germany')

--Q9 Obtain a count by department of the employees who started work with the corporation in 2003.

SELECT 
	department,
	COUNT(id) AS number_of_people_who_started_work_in_2003
FROM employees 
WHERE start_date BETWEEN '2003-01-01' AND '2003-12-31'
GROUP BY department
 
 --10 Obtain a table showing department, fte_hours and the number of employees in each department who work each fte_hours pattern. 
 --Order the table alphabetically by department, and then in ascending order of fte_hours.

SELECT 
	department,
	fte_hours,
	COUNT(id) AS number_of_employees_in_each_department
FROM employees 
GROUP BY 
	department,
	fte_hours
ORDER BY department ASC,
fte_hours ASC


--Q11 Obtain a table showing any departments in which there are two or more employees lacking a stored first name. 
--Order the table in descending order of the number of employees lacking a first name, and then in alphabetical order by department.

SELECT 
	department,
	COUNT(id) AS number_of_employees_missing_first_name
FROM employees 
WHERE first_name IS NULL
GROUP BY department  
HAVING COUNT(id) >= 2
ORDER BY count(id) DESC, department ASC

--Q12 Find the proportion of employees in each department who are grade 1.
 
SELECT 
COUNT(id)
FROM employees 
GROUP BY department

SELECT 
	sum(CAST(grade = 1 AS INT))
FROM employees 
GROUP BY department;




SELECT 
	department, 
      ROUND(CAST((sum(CAST(grade = 1 AS INT)))AS REAL) / CAST((COUNT(id))AS REAL)*100) AS percentage_number_are_grade_1
FROM employees
GROUP BY department

-- EXTENTION 
-- Q1 Do a count by year of the start_date of all employees, ordered most recent year last.

SELECT
	EXTRACT(YEAR FROM start_date) AS year_of_start_date, 
	COUNT(id) AS number_of_employees
FROM employees 
GROUP BY EXTRACT(YEAR FROM start_date) 
ORDER BY EXTRACT(YEAR FROM start_date) 