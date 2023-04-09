const express = require("express");
const router = express.Router();
const Users = require("../models/user");

router.get("/", async (req, res) => {
  try {
    const user = await Users.find();
    res.json(user);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

router.get("/:id", async (req, res) => {
  try {
    const my_uid = req.params.id;
    // console.log(my_uid);
    const user = await Users.findOne({ uid: my_uid });
    res.json(user);
  } catch (err) {}
});

router.post("/", async (req, res) => {
  const user = new Users({
    uid: req.body.uid,
    fullname: req.body.fullname,
    student: req.body.student,
    educationLevel: req.body.educationLevel,
  });
  // console.log(req);
  console.log(req.body);
  console.log("here");
  try {
    const newUser = await user.save();
    res.json(newUser);
  } catch (err) {
    res.status(400).json({ message: err.message });
  }
});

// PUT request to update a user
router.put("/:id", async (req, res) => {
  try {
    const my_uid = req.params.id;
    const user = await Users.findOne({ uid: my_uid });
    if (!user) {
      return res.status(404).json({ message: "User not found" });
    }
    if (req.body.fullname) {
      user.fullname = req.body.fullname;
    }
    if (req.body.student) {
      user.student = req.body.student;
    }
    if (req.body.educationLevel) {
      user.educationLevel = req.body.educationLevel;
    }

    const updatedUser = await user.save();
    res.json(updatedUser);
  } catch (err) {
    res.status(400).json({ message: err.message });
  }
});

router.delete("/:id", async (req, res) => {
  try {
    const deletedUser = await Users.findOneAndRemove({uid: req.params.id})
    if (!deletedUser) {
      return res.status(404).json({ message: "User not found" });
    }

    res.json({ message: "User deleted" });
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

module.exports = router;
