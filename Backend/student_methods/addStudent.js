const studentSignUp = require('../Models/student')
// POST API
const studentData = [];

const addStudent = async (req,res)=>{
    console.log("BACKEND RECIEVED:", req.body);

    let studentData = studentSignUp(req.body);
     try {
      let dataToStore = await studentData.save();
      res.status(200).json(dataToStore)
     } catch (error) {
      res.status(400).json({
        'status': error.message
      })
     }
}

module.exports = addStudent;
