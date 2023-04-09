const express = require("express");
const router = express.Router();
const PendingTuitions = require("../models/pending_tuitions");

router.get("/", async (req, res) => {
  try {
    const pendingTuitions = await PendingTuitions.find();
    // res.json(pendingTuitions);
    mappedTuitions = pendingTuitions.map((tuition) => {
      return {
        _id: tuition._id,
        student_id: tuition.student_id,
        tutor_id: tuition.tutor_id,
        topic: tuition.topic,
        subject: tuition.subject,
        longitude: tuition.student_location.coordinates[0],
        latitude: tuition.student_location.coordinates[1],
        start_time: tuition.start_time,
        bid_amount: tuition.bid_amount,
      };
    });
    res.json(mappedTuitions);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

// GET a specific pending tuition
router.get("/:id", getPendingTuition, (req, res) => {
  // console.log(res.pendingTuition)
  mappedTuition = {
    _id: res.pendingTuition._id,
    student_id: res.pendingTuition.student_id,
    tutor_id: res.pendingTuition.tutor_id,
    topic: res.pendingTuition.topic,
    subject: res.pendingTuition.subject,
    longitude: res.pendingTuition.student_location.coordinates[0],
    latitude: res.pendingTuition.student_location.coordinates[1],
    start_time: res.pendingTuition.start_time,
    bid_amount: res.pendingTuition.bid_amount,
  };
  res.json(mappedTuition);
});

// POST a new pending tuition
router.post("/", async (req, res) => {
  const pendingTuition = new PendingTuitions({
    student_id: req.body.student_id,
    tutor_id: req.body.tutor_id,
    topic: req.body.topic,
    subject: req.body.subject,
    student_location: {
      type: "Point",
      coordinates: [req.body.longitude, req.body.latitude],
    },
    start_time: req.body.start_time,
    bid_amount: req.body.bid_amount,
  });

  try {
    const newPendingTuition = await pendingTuition.save();
    res.status(201).json({message: "successful"});
  } catch (err) {
    res.status(400).json({ message: err.message });
  }
});

// PUT (update) a specific pending tuition
router.put("/:id", getPendingTuition, async (req, res) => {
  if (req.body._id != null) {
    res.pendingTuition._id = req.body.id;
  }
  if (req.body.student_id != null) {
    res.pendingTuition.student_id = req.body.student_id;
  }
  if (req.body.tutor_id != null) {
    res.pendingTuition.tutor_id = req.body.tutor_id;
  }
  if (req.body.topic != null) {
    res.pendingTuition.topic = req.body.topic;
  }
  if (req.body.subject != null) {
    res.pendingTuition.subject = req.body.subject;
  }
  if (req.body.longitude != null && req.body.latitude != null) {
    res.pendingTuition.student_location = {
      type: "Point",
      coordinates: [req.body.longitude, req.body.latitude],
    };
  }
  if (req.body.start_time != null) {
    res.pendingTuition.start_time = req.body.start_time;
  }
  if (req.body.end_time != null) {
    res.pendingTuition.end_time = req.body.end_time;
  }
  if (req.body.bid_amount != null) {
    res.pendingTuition.bid_amount = req.body.bid_amount;
  }

  try {
    const updatedPendingTuition = await res.pendingTuition.save();
    res.json(updatedPendingTuition);
  } catch (err) {
    res.status(400).json({ message: err.message });
  }
});

// DELETE a specific pending tuition
router.delete("/:id", getPendingTuition, async (req, res) => {
  try {
    await PendingTuitions.findByIdAndRemove(req.params.id);
    res.json({ message: "Pending tuition deleted" });
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

// !---------------------------------NON-BASIC FUNCTIONALITY----------------------------------------!
// add bids (use tuition ids)
/*{
  tutor_id : tutor_id,
  bid: bid
} 
*/
// router.put("/:id/bid", getPendingTuition, async (req, res) => {
//   const { tutor_id, bid_amount } = req.body;
//   const existingPendingTuition = res.pendingTuition;

//   // Check if the tutor has already placed a bid
//   const existingBidIndex = existingPendingTuition.tutor_bids.findIndex(
//     (bidObj) => bidObj.tutor_id === tutor_id
//   );
//   if (existingBidIndex !== -1) {
//     // Update the existing bid if it exists
//     existingPendingTuition.tutor_bids[existingBidIndex].bid_amount = bid_amount;
//   } else {
//     // Add a new bid to the tutor_bids array if the tutor has not placed a bid yet
//     existingPendingTuition.tutor_bids.push({ tutor_id, bid_amount });
//   }

//   try {
//     const updatedPendingTuition = await existingPendingTuition.save();
//     res.json(updatedPendingTuition);
//   } catch (err) {
//     res.status(400).json({ message: err.message });
//   }
// });

// tutor_id, bid amount

// start tuition
router.put("/:id/start", getPendingTuition, async (req, res) => {
  // console.log("here in start")
  const { pendingTuition } = res;

  // Create a new confirmed bid object
  // const index = pendingTuition.tutor_bids.findIndex(
  //   (bid) => bid.tutor_id === tutor_id
  // );

  // const bid = pendingTuition.tutor_bids[index].bid_amount;
  // pendingTuition.tutor_bids = [{ tutor_id, bid_amount: bid }];

  // Set the confirmed tutor ID and start time
  // pendingTuition.tutor_id = tutor_id;
  pendingTuition.start_time = new Date();
  try {
    await pendingTuition.save();
    res.status(200).json({ message: "Pending tuition started successfully" });
  } catch (err) {
    res.status(400).json({ message: err.message });
  }
});

// end tuition
// router.put("/:id/end", getPendingTuition, async (req,res)=> {
//   res.pendingTuition.end_time = new Date();
//   res.status(200).json({ message: "Pending tuition ended successfully"});

//   // implement moving this to confirmed tuitions
// })

// Middleware to get a specific pending tuition by ID
async function getPendingTuition(req, res, next) {
  let pendingTuition;
  try {
    pendingTuition = await PendingTuitions.findById(req.params.id);
    if (pendingTuition == null) {
      return res.status(404).json({ message: "Pending tuition not found" });
    }
  } catch (err) {
    return res.status(500).json({ message: err.message });
  }
  res.pendingTuition = pendingTuition;
  next();
}

module.exports = router;
