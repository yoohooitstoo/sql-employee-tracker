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
  salary DECIMAL(10,2) NOT NULL,
  department_id INT NOT NULL,
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

INSERT into department (department_name) VALUES ("Sales");
INSERT into department (department_name) VALUES ("Engineering");
INSERT into department (department_name) VALUES ("Finance");
INSERT into department (department_name) VALUES ("Legal");

INSERT into role (title, salary, department_id) VALUES ("Sales Lead", 100000, 1);
INSERT into role (title, salary, department_id) VALUES ("Salesperson", 80000, 1);
INSERT into role (title, salary, department_id) VALUES ("Lead Engineer", 150000, 2);
INSERT into role (title, salary, department_id) VALUES ("Soft Engineer", 90000, 2);
INSERT into role (title, salary, department_id) VALUES ("Accountant", 100000, 3);
INSERT into role (title, salary, department_id) VALUES ("Legal Team Lead", 30000, 4);
INSERT into role (title, salary, department_id) VALUES ("Lawyer", 30000, 4);

INSERT into employee (first_name, last_name, role_id, manager_id) VALUES ("John", "Doe", 1, null);
INSERT into employee (first_name, last_name, role_id, manager_id) VALUES ("Mike", "Chan", 1, null);
INSERT into employee (first_name, last_name, role_id, manager_id) VALUES ("Ashley", "Rodriquez", 2, null);
INSERT into employee (first_name, last_name, role_id, manager_id) VALUES ("Kevin", "Tupik", 2, 1);
INSERT into employee (first_name, last_name, role_id, manager_id) VALUES ("Malia", "Brown", 3, 2);
INSERT into employee (first_name, last_name, role_id, manager_id) VALUES ("Sarah", "Lourd", 4, null);
INSERT into employee (first_name, last_name, role_id, manager_id) VALUES ("Tom", "Allen", 4, 3);
INSERT into employee (first_name, last_name, role_id, manager_id) VALUES ("Christian", "Eckenrode", 2, 4);


SELECT * FROM department;
SELECT * FROM role;
SELECT * FROM employee;