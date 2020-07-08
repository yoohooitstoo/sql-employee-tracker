DROP DATABASE IF EXISTS employee_DB;

CREATE DATABASE employee_DB;

USE employee_DB;

CREATE TABLE department(
  id INT NOT NULL AUTO_INCREMENT,
  department_name VARCHAR(100) NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE role(
  id INT NOT NULL AUTO_INCREMENT,
  title VARCHAR(100) NOT NULL,
  salary DECIMAL(10,2) NOT NULL,
  deparment_id INT NOT NULL,
  PRIMARY KEY (id)
);
--   (department_id referes to employee) 
--   SELECT * FROM employee
--   RIGHT JOIN role on employee role_id = employee.role_id


CREATE TABLE employee(
    id INT NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    role_id INT NULL,
    manager_id INT NULL,
    PRIMARY KEY(id)
);

-- role_id INT DEFAULT (reference to same employee),
-- manager_id INT (reference another employee) NULL,