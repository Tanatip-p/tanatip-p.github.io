USE employees;

# Exercise 1
# Find the average salary of male and female employees in each department.
SELECT
    d.dept_name, e.gender, ROUND(AVG(salary), 2) as average_salary
FROM
    salaries s
        JOIN
    employees e ON s.emp_no = e.emp_no
        JOIN
    dept_emp de ON e.emp_no = de.emp_no
        JOIN
    departments d ON d.dept_no = de.dept_no
GROUP BY de.dept_no , e.gender
ORDER BY de.dept_no;

SELECT MIN(dept_no)
FROM dept_emp;

SELECT MAX(dept_no)
FROM dept_emp;
    
SELECT
    emp_no,
    (SELECT
            MIN(dept_no)
        FROM
            dept_emp de
        WHERE
            e.emp_no = de.emp_no) dept_no,
    CASE
        WHEN emp_no <= 10020 THEN '110022'
        ELSE '110039'
    END AS manager
FROM
    employees e
WHERE
    emp_no <= 10040; 

SELECT *
FROM employees
WHERE YEAR(hire_date) = 2000;

SELECT *
FROM titles
WHERE title LIKE ('%engineer%');

SELECT *
FROM titles
WHERE title LIKE ('%senior engineer%');    

DROP procedure IF EXISTS last_department;

DELIMITER $$
CREATE PROCEDURE last_department (in p_emp_no integer)
BEGIN
SELECT
    e.emp_no, d.dept_no, d.dept_name
FROM
    employees e
        JOIN
    dept_emp de ON e.emp_no = de.emp_no
        JOIN
    departments d ON de.dept_no = d.dept_no
WHERE
    e.emp_no = p_emp_no
        AND de.from_date = (SELECT
            MAX(from_date)
        FROM
            dept_emp
        WHERE
            emp_no = p_emp_no);
END$$
DELIMITER ;

call employees.last_department(10010);

SELECT COUNT(*) as num_contact
FROM salaries
WHERE salary >= 100000 AND DATEDIFF(to_date, from_date) > 365;

DROP TRIGGER IF EXISTS trig_hire_date;

DELIMITER $$
CREATE TRIGGER trig_hire_date
BEFORE INSERT ON employees
 
FOR EACH ROW
BEGIN 
    DECLARE today date;
    SELECT date_format(sysdate(), '%Y-%m-%d') INTO today;
 
	IF NEW.hire_date > today THEN
		SET NEW.hire_date = today;
	END IF;
END $$
 
DELIMITER ;

DROP FUNCTION IF EXISTS f_highest_salary;

DELIMITER $$
CREATE FUNCTION f_highest_salary (p_emp_no INTEGER) RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN

DECLARE v_highest_salary DECIMAL(10,2);

SELECT
    MAX(s.salary)
INTO v_highest_salary FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
WHERE
    e.emp_no = p_emp_no;

RETURN v_highest_salary;
END$$

DELIMITER ;

SELECT f_highest_salary(11356);

DROP FUNCTION IF EXISTS f_lowest_salary;

DELIMITER $$
CREATE FUNCTION f_lowest_salary (p_emp_no INTEGER) RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN

DECLARE v_lowest_salary DECIMAL(10,2);

SELECT
    MIN(s.salary)
INTO v_lowest_salary FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
WHERE
    e.emp_no = p_emp_no;

RETURN v_lowest_salary;
END$$

DELIMITER ;


SELECT f_lowest_salary(10356);

DROP FUNCTION IF EXISTS f_salary;

DELIMITER $$
CREATE FUNCTION f_salary (p_emp_no INTEGER, p_min_or_max varchar(10)) RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN

DECLARE v_salary_info DECIMAL(10,2);

SELECT
    CASE
        WHEN p_min_or_max = 'max' THEN MAX(s.salary)
        WHEN p_min_or_max = 'min' THEN MIN(s.salary)
        ELSE MAX(s.salary) - MIN(s.salary)
    END AS salary_info
INTO v_salary_info FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
WHERE
    e.emp_no = p_emp_no;

RETURN v_salary_info;
END$$

DELIMITER ;

select employees.f_salary(11356, 'min');
select employees.f_salary(11356, 'max');
select employees.f_salary(11356, 'maxxx');
