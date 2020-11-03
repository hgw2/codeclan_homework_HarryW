--LAB AND HOMEWORK
--Q1 Get a table of all employees details, together with their local_account_no and local_sort_code, if they have them.

SELECT 
	e.*,
	pd.local_account_no,
	pd.local_sort_code
FROM employees AS e LEFT JOIN pay_details AS pd
ON e.pay_detail_id = pd.id

--Q2 Amend your query from question 1 above to also return the name of the team that each employee belongs to.

SELECT 
	e.*,
	pd.local_account_no,
	pd.local_sort_code,
	t.name
FROM employees AS e LEFT JOIN pay_details AS pd 
ON e.pay_detail_id = pd.id LEFT JOIN teams AS t ON e.team_id = t.id

-- Q3 Find the first name, last name and team name of employees who are members of teams for which the charge cost is greater than 80. 
--Order the employees alphabetically by last name.

SELECT 
	e.first_name,
	e.last_name,
	t.name 
FROM employees AS e LEFT JOIN teams AS t
ON e.team_id = t.id 
WHERE CAST(t.charge_cost AS INT)  > 80
ORDER BY e.last_name ASC NULLS LAST

--Q4 Breakdown the number of employees in each of the teams, including any teams without members. Order the table by increasing size of team.

SELECT 
	t.name,
	COUNT(e.id) AS number_of_emplyees
FROM employees AS e RIGHT JOIN teams AS t 
ON e.team_id = t.id 
GROUP BY t.name
ORDER BY COUNT(e.id) ASC NULLS FIRST

--Q5 The effective_salary of an employee is defined as their fte_hours multiplied by their salary. 
--Get a table for each employee showing their id, first_name, last_name, fte_hours, salary and effective_salary, 
--along with a running total of effective_salary with employees placed in ascending order of effective_salary.

SELECT 
    id,
    first_name,
    last_name,
    fte_hours,
    salary,
    salary * fte_hours AS effective_salary,
    sum(salary * fte_hours) OVER (ORDER BY salary * fte_hours ASC NULLS LAST) AS running_effective_salary
FROM employees


--Q6 The total_day_charge of a team is defined as the charge_cost of the team multiplied by the number of employees in the team. 
-- Calculate the total_day_charge for each team.

WITH team_count(name, charge, num_employees) AS (
SELECT
	t.name,
	CAST(t.charge_cost AS int),
	count(e.id)
FROM employees AS e INNER JOIN teams AS t 
ON e.team_id = t.id
GROUP BY t.name, t.charge_cost
)
SELECT 
	t.name,
	team_count.num_employees,
	team_count.charge,
	team_count.charge * team_count.num_employees AS total_day_charge
FROM teams AS t INNER JOIN team_count 
ON t.name = team_count.name


Q7 - How would you amend your query from question 6 above to show only those teams with a total_day_charge greater than 5000?

WITH team_count(name, charge, num_employees) AS (
SELECT
	t.name,
	CAST(t.charge_cost AS int),
	count(e.id)
FROM employees AS e INNER JOIN teams AS t 
ON e.team_id = t.id
GROUP BY t.name, t.charge_cost
)
SELECT 
	t.name,
	team_count.num_employees,
	team_count.charge,
	team_count.charge * team_count.num_employees AS total_day_charge
FROM teams AS t INNER JOIN team_count 
ON t.name = team_count.name
WHERE team_count.charge * team_count.num_employees > 5000

