const express = require('express');
const router = express.Router();
const courseController = require('../controllers/course.controller');
const { checkAdmin, checkTeacher, checkStudent } = require('../middleware/auth.middleware');

// Set course availability (Admin only)
router.put("/availability", checkAdmin, courseController.updateAvailability);

// Assign teacher to course (Admin only)
router.put("/assign-teacher", checkAdmin, courseController.assignCourseToTeacher);

// List available courses (Public)
router.get("/available", courseController.listAvailableCourses);

// Enroll in a course (Student only)
router.post("/enroll", checkStudent, courseController.enrollCourse);

// Update a student's mark (Teacher only)
router.put("/update-mark", checkTeacher, courseController.updateMark);

module.exports = router;
