const express = require("express");
const router = express.Router();
const ActiveTutors = require("../models/active_tutors");

// Save tutor
router.post("/", async (req, res) => {
  const { uid, latitude, longitude } = req.body;
  const active_tutor = new ActiveTutors({
    uid,
    location: {
      type: "Point",
      coordinates: [longitude, latitude],
    },
  });
  try {
    const newTutor = await active_tutor.save();
    res.json(newTutor);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

// get all tutors
router.get("/", async (req, res) => {
  try {
    const activeTutor = await ActiveTutors.find();
    const mappedTutor = activeTutor.map((tutor) => {
      return {
        uid: tutor.uid,
        longitude: tutor.location.coordinates[0],
        latitude: tutor.location.coordinates[1],
      };
    });
    res.json(mappedTutor);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

// get one tutor
router.get("/:id", async (req, res) => {
  try {
    const id = req.params.id;
    const activeTutor = await ActiveTutors.findOne({ uid: id });
    const mappedTutor = {
      uid: activeTutor.uid,
      longitude: activeTutor.location.coordinates[0],
      latitude: activeTutor.location.coordinates[1],
    };
    res.json(mappedTutor);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

router.post("/find", async (req, res) => {
  const longitude = req.body.longitude;
  const latitude = req.body.latitude;
  res.json(await findTutorsWithinRadius(longitude, latitude, 5000));
});

router.delete("/:id", async (req, res)=>{
  try{
    const deletedTutor = await ActiveTutors.findOneAndRemove({uid: req.params.id})
    if (!deletedTutor) {
      return res.status(404).json({ message: "Active Tutor not found" });
    }
    res.json({message: "Deleted Active Tutor"})
  } catch(err){
    res.status(500).json({message: err.message})
  }
})

async function findTutorsWithinRadius(longitude, latitude, radius) {
  // console.log(longitude, latitude);
  const tutors = await ActiveTutors.aggregate([
    {
      $geoNear: {
        near: {
          type: "Point",
          coordinates: [longitude, latitude],
        },
        distanceField: "distance",
        maxDistance: radius,
        spherical: true,
      },
    },
  ]);
  const mappedTutor = tutors.map((tutor) => {
    return {
      uid: tutor.uid,
      longitude: tutor.location.coordinates[0],
      latitude: tutor.location.coordinates[1],
      distance: tutor.distance
    };
  });
  return mappedTutor;
}

module.exports = router;
