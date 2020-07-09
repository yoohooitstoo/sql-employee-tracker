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
    database: "employee_DB"
  });
  
  // connect to the mysql server and sql database
  connection.connect(function(err) {
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
     backgroundColor: "#555555"
    };
    const msgBox = boxen( greeting, boxenOptions );
    
    console.log(msgBox);
    start();
};
  

  function start() {
    
    inquirer
      .prompt({
        name: "createEmployee",
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
      .then(function(answer) {
        // based on their answer, either call the bid or the post functions
        if(action === "View All Employees") {
            viewEmployees();
        } if (action === "View All Employees By Department") {
            viewDepartment();
        } if (action === "View Employees By Manager") {
            viewManager();
        } if (action === "Add Employee") {
            addEmployee();
        } if (action === "Remove Employee") {
            removeEmployee();
        } if (action === "Update Employee Role") {
            updateRole();
        } if (action === "Update Employee Manager") {
            updateManager();
        } if (action === "View All Roles") {
            viewRoles();
        } else {
            exit();
        }
      });
  };