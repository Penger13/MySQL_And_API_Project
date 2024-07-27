const express = require('express');
const bodyParser = require('body-parser');
const mysql = require('mysql');
const dbConfig = require('./config/db.config');
const port = 3000;

const app = express();

// Parse requests of content-type: application/json
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

// Create a connection to the database
const connection = mysql.createConnection({
    host: dbConfig.HOST,
    user: dbConfig.USER,
    password: dbConfig.PASSWORD,
    database: dbConfig.DB
});

// Open the MySQL connection
connection.connect(error => {
    if (error) throw error;
    console.log("Successfully connected to the database.");
});

// Simple route
app.get("/", (req, res) => {
    res.json({ message: "Welcome to the application." });
});

// Routes
const courseRoutes = require('./routes/course.routes');
app.use('/courses', courseRoutes);

// Start the server
app.listen(port, () => {
    console.log(`Server is running on port ${port}`);
});
