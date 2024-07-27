const sql = require('mysql');
const dbConfig = require('../config/db.config');

const connection = sql.createConnection({
  host: dbConfig.HOST,
  user: dbConfig.USER,
  password: dbConfig.PASSWORD,
  database: dbConfig.DB
});


// Enable or disable course availability (Admin Only)
exports.updateAvailability = (req, res) => {
  const { courseId, isAvailable, userId } = req.body;

  connection.query(
    "UPDATE courses SET isAvailable = ? WHERE CourseID = ? AND EXISTS (SELECT 1 FROM users WHERE UserID = ? AND RoleID = 1)",
    [isAvailable, courseId, userId],
    (err, result) => {
      if (err) {
        res.status(500).send({ message: err.message });
      } else {
        res.send(result);
      }
    }
  );
};

// Assign one or more courses to a teacher (Admin Only)
exports.assignCourseToTeacher = (req, res) => {
  const { courseId, teacherId, userId } = req.body;

  connection.query(
    "UPDATE courses SET TeacherID = ? WHERE CourseID = ? AND EXISTS (SELECT 1 FROM users WHERE UserID = ? AND RoleID = 1)",
    [teacherId, courseId, userId],
    (err, result) => {
      if (err) {
        res.status(500).send({ message: err.message });
      } else {
        res.send(result);
      }
    }
  );
};

// List all available courses and their teachers (Public)
exports.listAvailableCourses = (req, res) => {
  connection.query(
    "SELECT c.Title as course_title, u.Name as teacher_name FROM courses c LEFT JOIN users u ON c.TeacherID = u.UserID WHERE c.isAvailable = 1",
    (err, result) => {
      if (err) {
        res.status(500).send({ message: err.message });
      } else {
        res.send(result);
      }
    }
  );
};

// Enroll a student in a course (Student Only)
exports.enrollCourse = (req, res) => {
  const { studentId, courseId, userId } = req.body;

  connection.query(
    "INSERT INTO enrolments (UserID, CourseID) SELECT ?, ? WHERE NOT EXISTS (SELECT 1 FROM enrolments WHERE UserID = ? AND CourseID = ?) AND EXISTS (SELECT 1 FROM users WHERE UserID = ? AND RoleID = 3)",
    [studentId, courseId, studentId, courseId, userId],
    (err, result) => {
      if (err) {
        res.status(500).send({ message: err.message });
      } else {
        res.send(result);
      }
    }
  );
};

// Update a student's mark (Teacher Only)
exports.updateMark = (req, res) => {
  const { studentId, courseId, mark, userId } = req.body;

  connection.query(
    "UPDATE enrolments SET Mark = ? WHERE UserID = ? AND CourseID = ? AND EXISTS (SELECT 1 FROM users WHERE UserID = ? AND RoleID = 2)",
    [mark, studentId, courseId, userId],
    (err, result) => {
      if (err) {
        res.status(500).send({ message: err.message });
      } else {
        res.send(result);
      }
    }
  );
};