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

router.get('/:id', async(req,res)=>{
    try{
        const my_uid = req.params.id;
        console.log(my_uid);
        const user = await Users.findOne({uid: my_uid})
        res.json(user)
    }
    catch(err){

    }
})

router.post('/', async(req, res)=> {
    const user = new Users({
        uid: req.body.uid,
        fullname: req.body.fullname,
        student: req.body.student,
        educationLevel: req.body.educationLevel,
    })
    // console.log(req);
    console.log(req.body);
    console.log("here");
    try{
        const newUser = await user.save()
        res.json(newUser)
    }catch(err){
        res.status(400).json({message: err.message})
    }
})

module.exports = router