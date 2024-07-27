const sql = require('mysql');
const dbConfig = require('../config/db.config');

const connection = sql.createConnection({
  host: dbConfig.HOST,
  user: dbConfig.USER,
  password: dbConfig.PASSWORD,
  database: dbConfig.DB
});

const checkRole = (roleId) => (req, res, next) => {
  const { userId } = req.body;

  connection.query(
    "SELECT RoleID FROM users WHERE UserID = ?",
    [userId],
    (err, results) => {
      if (err) {
        res.status(500).send({ message: err.message });
      } else if (results.length === 0 || results[0].RoleID !== roleId) {
        res.status(403).send({ message: "Access denied" });
      } else {
        next();
      }
    }
  );
};

exports.checkAdmin = checkRole(1);
exports.checkTeacher = checkRole(2);
exports.checkStudent = checkRole(3);
