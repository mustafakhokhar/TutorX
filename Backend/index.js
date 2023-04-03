const express = require("express");
const mongoose = require("mongoose");
// const studentRoutes = require("./routes/student_routes");
// const addStudent = require("./student_methods/addStudent");
// const getAllStudents = require("./student_methods/getAllStudents")
const userRouter = require("./routes/user")

const app = express();

app.use(express.json());

app.use(
  express.urlencoded({
    extended: true,
  })
);

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
    // API Data for Students from Frontend
    // app.use("/api/student/add_student_details",addStudent)
    // app.use("/api/student/get_all_students",getAllStudents)
    app.use("/user", userRouter)
  }).catch((error)=>{
    console.log(error.message);
  });

// const PORT = process.env.PORT || 2000; //port for https

app.listen(3000, () => {
  console.log("Connected to server localhost:3000");
});
