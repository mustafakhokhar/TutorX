const express = require("express");
const mongoose = require("mongoose");
const userRouter = require("./routes/user")
const activeTutorsRouter = require("./routes/active_tutors")
const pendingTuitions = require("./routes/pending_tuitions")
const confirmedTuitions = require("./routes/confirmed_tuitions")
const devices = require("./routes/devices")


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
    app.use("/user", userRouter)
    app.use("/activeTutors", activeTutorsRouter)
    app.use("/pendingTuitions", pendingTuitions)
    app.use("/confirmedTuitions", confirmedTuitions)
    app.use("/devices", devices)

  }).catch((error)=>{
    console.log(error.message);
  });

// const PORT = process.env.PORT || 2000; //port for https

app.listen(3000, () => {
  console.log("Connected to server localhost:3000");
});
