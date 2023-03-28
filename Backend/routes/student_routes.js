const express = require("express");
const addStudent = require("../student_methods/addStudent");

const router = express.Router()

router.get("/add_student_details",addStudent)

module.exports = router;