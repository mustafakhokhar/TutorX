const studentSignUp = require('../student')
// POST API
const studentData = [];

const addStudent = async (req,res)=>{
    console.log("Result:", req.body);

    let studentData = studentSignUp(req.body);
     try {
      let dataToStore = await studentData.save();
      res.status(200).json(dataToStore)
     } catch (error) {
      res.status(400).json({
        'status': error.message
      })
     }
  
    // const temp = {
    //   id: studentData.length + 1,
    //   fullname: req.body.fullname,
    //   email: req.body.email,
    //   number: req.body.number,
    // };
    // ``;
    // studentData.push(temp);
    // console.log("Final", temp);
  
    // res.status(200).send({
    //   status_code: 200,
    //   message: "Student added sucessfully",
    //   student: temp,
    // });
}

module.exports = addStudent;
