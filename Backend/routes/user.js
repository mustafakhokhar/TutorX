const express = require("express")
const router = express.Router()
const Users = require('../models/user')

router.get('/',async (req, res)=> {
    try {
        const user = await Users.find()
        res.json(user)
    }
    catch(err){
        res.status(500).json({message: err.message})
    }
})

router.post('/', async(req, res)=> {
    const user = new Users({
        uid: req.body.uid,
        fullname: req.body.fullname,
        student: req.body.student,
        educationLevel: req.body.educationLevel,
    })
    console.log(user);
    console.log("here");
    try{
        const newUser = await user.save()
        res.json(newUser)
    }catch(err){
        res.status(400).json({message: err.message})
    }
})

module.exports = router