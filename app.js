// require mysql
const mysql = require("mysql");
//require inquirer
const inquirer = require("inquirer");

const chalk = require("chalk");
const boxen = require("boxen");

//build out the sql connection
const connection = mysql.createConnection({
  host: "localhost",

  // Your port; if not 3306
  port: 3306,

  // Your username
  user: "root",

  // Your password
  password: "Okawana1492",
  database: "employee_DB",
});

// connect to the mysql server and sql database
connection.connect(function (err) {
  if (err) throw err;
  // run the start function after the connection is made to prompt the user

  displaySign();
});

function displaySign() {
  const greeting = chalk.white.bold("EMPLOYEE TRACKER");
  const boxenOptions = {
    padding: 1,
    margin: 1,
    borderStyle: "round",
    borderColor: "green",
    backgroundColor: "#555555",
  };
  const msgBox = boxen(greeting, boxenOptions);

  console.log(msgBox);
  start();
}

function start() {
  inquirer
    .prompt({
      name: "action",
      type: "list",
      message: "What would you like to do?",
      choices: [
        "View All Employees",
        "View All Employees By Department",
        "View All Employees By Manager",
        "Add Employee",
        "Remove Employee",
        "Update Employee Role",
        "Update Employee Manager",
        "View All Roles",
        "exit",
      ],
    })
    .then(function ({ action }) {
      // based on their answer, either call the bid or the post functions
      if (action === "View All Employees") {
        viewEmployees();
      } else if (action === "View All Employees By Department") {
        viewDepartment();
      } else if (action === "View All Employees By Manager") {
        viewManager();
      } else if (action === "Add Employee") {
        addEmployee();
      } else if (action === "Add Manager") {
        addEmployee();
      } else if (action === "Add Department") {
          addEmployee();
      } else if (action === "Remove Employee") {
        removeEmployee();
      } else if (action === "Update Employee Role") {
        updateRole();
      } else if (action === "Update Employee Manager") {
        updateManager();
      } else if (action === "View All Roles") {
        viewRoles();
      } else {
        exit();
      }
    });
}

const viewEmployees = () => {
  const query = `SELECT employee.first_name, employee.last_name, role.title, department.department_name, role.salary, manager.first_name AS manager_first, manager.last_name AS manager_last FROM employee
    LEFT JOIN role ON employee.role_id = role.id
    LEFT JOIN department ON role.department_id = department.id
    LEFT JOIN employee manager ON manager.id = employee.manager_id;`;
  connection.query(query, function (err, res) {
    for (var i = 0; i < res.length; i++) {}
    if (err) throw err;
    console.table(res);
    start();
  });
};

const viewDepartment = () => {
  const query = `SELECT department.id, department.department_name, 
  employee.first_name, employee.last_name, role.title
  FROM employee
  LEFT JOIN role ON employee.role_id = role.id
  LEFT JOIN department ON department.id = role.department_id;`;
  connection.query(query, function (err, res) {
    for (var i = 0; i < res.length; i++) {}
    if (err) throw err;
    console.table(res);
    start();
  });
};

const viewManager = () => {
  const query = `SELECT employee.id, employee.first_name, employee.last_name, role.title, department.department_name, employee.manager_id, manager.first_name AS manager_first, manager.last_name AS manager_last 
    FROM employee 
    LEFT JOIN role ON employee.role_id = role.id 
    LEFT JOIN department ON role.department_id = department.id 
    LEFT JOIN employee manager ON manager.id = employee.manager_id;`;
  connection.query(query, function (err, res) {
    for (var i = 0; i < res.length; i++) {}
    if (err) throw err;
    console.table(res);
    start();
  });
};

const addEmployee = () => {
  connection.query("SELECT * FROM role", (err, data) => {
    if (err) throw err;
    // console.log(data);
    const arrayOfTitles = data.map((object) => {
      return { name: object.title, value: object.id };
    });
    connection.query("SELECT * FROM employee", (err, data) => {
      if (err) throw err;
      // console.log(data);
      const arrayOfManagers = data.map((managers) => {
        return { name: managers.first_name, value: managers.id };
      });
    // console.log(arrayOfTitles);
    inquirer
      .prompt([
        {
          type: "input",
          message: "What is your new employee's first name?",
          name: "first_name",
        },
        {
          type: "input",
          message: "What is your new employee's last name?",
          name: "last_name",
        },
        {
          type: "list",
          message: "Please select the employee's job role:",
          choices: arrayOfTitles,
          name: "role_id",
        },
        {
          type: "list",
          message: "Please select the employee's manager:",
          choices: arrayOfManagers,
          name: "manager_id",
        },
      ])
      .then((response) => {
        console.log(response);
        connection.query("INSERT INTO employee SET ?", response, (err, res) => {
          if (err) throw err;
          connection.query("SELECT * FROM employee", (err, res) => {
            if (err) throw err;
            console.table(res);
            start();
          });    
        });
      });
    });
  });
};


const removeEmployee = () => {
  connection.query("SELECT * FROM employee", function (err, results) {
    if (err) throw err;
    inquirer
      .prompt({
        name: "employee",
        type: "list",
        message: "Who would you like to remove?",
        choices: function () {
          const choicesArray = [];
          for (var i = 0; i < results.length; i++) {
            const employeeObject = {
              name: `${results[i].first_name} ${results[i].last_name}`,
              value: results[i].id,
            };
            choicesArray.push(employeeObject);
          }
          return choicesArray;
        },
      })
      // Functionality works need to actually delete
      .then(function (answer) {
        const query = "DELETE FROM employee WHERE id = ?";
        connection.query(query, answer.employee, function (err, results) {
          if (err) throw err;
          connection.query("SELECT * FROM employee", (err, res) => {
            if (err) throw err;
            console.log("You removed an employee");
            console.table(res);
            start();
          });
        });
      });
  });
};

const updateRole = () => {
  connection.query("SELECT * FROM employee", function (err, results) {
    if (err) throw err;
    inquirer
      .prompt({
        name: "employee",
        type: "list",
        message: "Who's role would you like to change?",
        choices: function () {
          const choicesArray = [];
          for (var i = 0; i < results.length; i++) {
            const employeeObject = {
              name: `${results[i].first_name} ${results[i].last_name}`,
              value: results[i].id,
            };
            choicesArray.push(employeeObject);
          }
          return choicesArray;
        },
      })
      // Functionality works need to actually delete
      .then(function (answer) {
        const query = "DELETE FROM employee WHERE id = ?";
        connection.query(query, answer.employee, function (err, results) {
          if (err) throw err;
          connection.query("SELECT * FROM employee", (err, res) => {
            if (err) throw err;
            console.log("You removed an employee");
            console.table(res);
            start();
          });
        });
      });
  });
};

const updateManager = () => {
  console.log("here");
  start();
};

const viewRoles = () => {
  const query =
    "SELECT role.title, role.salary, role.department_id, department.department_name FROM role LEFT JOIN department ON role.department_id = department.id;";
  connection.query(query, function (err, res) {
    for (var i = 0; i < res.length; i++) {}
    if (err) throw err;
    console.table(res);
    start();
  });
};

const exit = () => {
  console.log("you exited");
  connection.end();
};
