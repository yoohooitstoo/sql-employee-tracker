DROP DATABASE IF EXISTS employee_DB;

CREATE DATABASE employee_DB;

USE employee_DB;

CREATE TABLE department(
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  department_name VARCHAR(30) NOT NULL
);

CREATE TABLE role(
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(30) NOT NULL,
  salary DECIMAL(10,2) NOT NULL DEFAULT (50000),
  department_id INT,
  FOREIGN KEY (department_id) REFERENCES department(id)
);
--   (department_id referes to employee) 
--   SELECT * FROM employee
--   RIGHT JOIN role on employee role_id = employee.role_id

CREATE TABLE employee(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(30),
    last_name VARCHAR(30) NOT NULL,
    role_id INT NULL,
    manager_id INT NULL,
    FOREIGN KEY (role_id) REFERENCES role(id),
    FOREIGN KEY (manager_id) REFERENCES role(id)
);

-- role_id INT DEFAULT (reference to same employee),
-- manager_id INT (reference another employee) NULL,

INSERT into department (department_name) VALUES 
("Sales"), ("Engineering"), ("Finance"), ("Legal");

INSERT into role (title, salary, department_id) VALUES 
("Sales Lead", 100000, 1),("Salesperson", 80000, 1), ("Lead Engineer", 150000, 2), ("Soft Engineer", 90000, 2),
("Accountant", 100000, 3), ("Legal Team Lead", 30000, 4), ("Lawyer", 30000, 4);

INSERT into employee (first_name, last_name, role_id, manager_id) VALUES 
("John", "Doe", 1, null), ("Mike", "Chan", 1, null), ("Ashley", "Rodriquez", 2, null), ("Kevin", "Tupik", 2, 1),
("Malia", "Brown", 3, 2), ("Sarah", "Lourd", 4, null), ("Tom", "Allen", 4, 3), ("Christian", "Eckenrode", 2, 4);


SELECT * FROM department;
SELECT * FROM role;
SELECT * FROM employee;

-- EMPLOYEE MANAGERS!!!!
SELECT employee.id, employee.first_name, employee.last_name, role.title, department.department_name, employee.manager_id, manager.first_name AS manager_first, manager.last_name AS manager_last FROM employee
LEFT JOIN role ON employee.role_id = role.id
LEFT JOIN department ON role.department_id = department.id
LEFT JOIN employee manager ON manager.id = employee.manager_id;
-- VIEW EMPLOYEES
SELECT employee.id, employee.first_name, employee.last_name, department.department_name, role.salary, manager.first_name AS manager_first, manager.last_name AS manager_last FROM employee
LEFT JOIN role ON employee.role_id = role.id
LEFT JOIN department ON role.department_id = department.id
LEFT JOIN employee manager ON manager.id = employee.manager_id;
-- Employees by Department
SELECT department.id, department.department_name, employee.first_name, employee.last_name, role.title
FROM department
LEFT JOIN employee ON department.id = employee.role_id
LEFT JOIN role ON department.id = role.department_id;
-- View All Roles
SELECT role.title, role.salary, role.department_id, department.department_name FROM role
LEFT JOIN department ON role.department_id = department.id;