
/* Functional Requirements Queries to connect to API */

-- 1) Admins should be able to enable or disable the availability of a course
UPDATE courses
SET isAvailable = ?
WHERE CourseID = ?
AND EXISTS (SELECT 1 FROM users WHERE UserID = ? AND RoleID = 1);

-- 2) Admins should be able to assign one or more courses to a teacher
UPDATE courses
SET TeacherID = ?
WHERE CourseID = ?
AND EXISTS (SELECT 1 FROM users WHERE UserID = ? AND RoleID = 1);

-- 3) Students can browse and list all the available courses and see the course title and course teacher’s name. 
SELECT c.Title as course_title, u.Name as teacher_name
FROM courses c
LEFT JOIN users u ON c.TeacherID = u.UserID
WHERE c.isAvailable = 1;

-- 4) Students can enrol in a course. Students should not be able to enrol in a course more than once at each time. 
INSERT INTO enrolments (UserID, CourseID)
SELECT ?, ?
WHERE NOT EXISTS (SELECT 1 FROM enrolments WHERE UserID = ? AND CourseID = ?)
AND EXISTS (SELECT 1 FROM users WHERE UserID = ? AND RoleID = 3);

-- 5) Teachers can fail or pass a student.
UPDATE enrolments
SET Mark = ?
WHERE UserID = ? 
AND CourseID = ?
AND EXISTS (SELECT 1 FROM courses WHERE CourseID = ? AND TeacherID = ?)
AND EXISTS (SELECT 1 FROM users WHERE UserID = ? AND RoleID = 2);

-- 6) Access control for Admins, Teachers and Students: Ensure only the authorized access can perform an action. For example, only teachers can pass/fail a student. 
-- This requirement got integrated in the queries ('And Exists' lines)