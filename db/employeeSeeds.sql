INSERT into department (department_name) VALUES 
("Sales"), ("Engineering"), ("Finance"), ("Legal");

INSERT into role (title, salary, department_id) VALUES 
("Sales Lead", 100000, 1),("Salesperson", 80000, 1), ("Lead Engineer", 150000, 2), ("Soft Engineer", 90000, 2),
("Accountant", 100000, 3), ("Legal Team Lead", 30000, 4), ("Lawyer", 30000, 4);

INSERT into employee (first_name, last_name, role_id, manager_id) VALUES 
("John", "Doe", 1, null), ("Mike", "Chan", 2, null), ("Ashley", "Rodriquez", 3, null), ("Kevin", "Tupik", 4, 1),
("Malia", "Brown", 5, 2), ("Sarah", "Lourd", 6, null), ("Tom", "Allen", 7, 3), ("Christian", "Eckenrode", 3, 4);


SELECT * FROM department;
SELECT * FROM role;
SELECT * FROM employee;

-- EMPLOYEE MANAGERS!!!!
SELECT employee.first_name, employee.last_name, role.title, department.department_name, employee.manager_id, manager.first_name AS manager_first, manager.last_name AS manager_last FROM employee
LEFT JOIN role ON employee.role_id = role.id
LEFT JOIN department ON role.department_id = department.id
LEFT JOIN employee manager ON manager.id = employee.manager_id;

-- VIEW EMPLOYEES
SELECT employee.first_name, employee.last_name, role.title, department.department_name, role.salary, manager.first_name AS manager_first, manager.last_name AS manager_last FROM employee
LEFT JOIN role ON employee.role_id = role.id
LEFT JOIN department ON role.department_id = department.id
LEFT JOIN employee manager ON manager.id = employee.manager_id;

-- Employees by Department
SELECT department.id, department.department_name, employee.first_name, employee.last_name, role.title
FROM employee
LEFT JOIN role ON employee.role_id = role.id
LEFT JOIN department ON department.id = role.department_id;

-- View All Roles
SELECT role.title, role.salary, role.department_id, department.department_name FROM role
LEFT JOIN department ON role.department_id = department.id;