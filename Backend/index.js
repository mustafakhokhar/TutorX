const express = require("express");
const mongoose = require("mongoose");
const studentRoutes = require("./routes/student_routes");
const addStudent = require("./student_methods/addStudent");

const app = express();

app.use(express.json());

app.use(
  express.urlencoded({
    extended: true,
  })
);

const studentData = [];

// connext to moongose
mongoose.set('strictQuery', true)
mongoose.connect("mongodb+srv://mustafa:helloworld@tutorxcluster.42lny5j.mongodb.net/tutorx",
    {
      useNewUrlParser: true,
      useUnifiedTopology: true,
    }
  )
  .then(()=>{
    console.log("Connected to Mongoose");
    app.use("/api/student/add_student_details",addStudent)
  }).catch((error)=>{
    console.log(error.message);
  });

const PORT = process.env.PORT || 2000; //port for https

// 


// POST API
// app.post("/api/student/add_student_details", (req, res) => {
//   console.log("Result:", req.body);

//   const temp = {
//     id: studentData.length + 1,
//     name: req.body.name,
//     email: req.body.email,
//     number: req.body.number,
//   };
//   ``;
//   studentData.push(temp);
//   console.log("Final", temp);

//   res.status(200).send({
//     status_code: 200,
//     message: "Student added sucessfully",
//     student: temp,
//   });
// });

app.listen(PORT, () => {
  console.log("Connected to server @ 2000");
});
