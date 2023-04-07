const express = require("express");
const router = express.Router();
const PendingTuitions = require("../models/pending_tuitions");

router.get("/", async (req, res) => {
  try {
    const pendingTuitions = await PendingTuitions.find();
    res.json(pendingTuitions);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

// GET a specific pending tuition
router.get("/:id", getPendingTuition, (req, res) => {
  res.json(res.pendingTuition);
});

// POST a new pending tuition
router.post("/", async (req, res) => {
  const pendingTuition = new PendingTuitions({
    tuition_id: req.body.tuition_id,
    student_id: req.body.student_id,
    tutor_id: req.body.tutor_id,
    topic: req.body.topic,
    student_location: req.body.student_location,
    start_time: req.body.start_time,
    end_time: req.body.end_time,
    tutor_bids: req.body.tutor_bids,
  });

  try {
    const newPendingTuition = await pendingTuition.save();
    res.status(201).json(newPendingTuition);
  } catch (err) {
    res.status(400).json({ message: err.message });
  }
});

// PUT (update) a specific pending tuition
router.put("/:id", getPendingTuition, async (req, res) => {
  if (req.body.tuition_id != null) {
    res.pendingTuition.tuition_id = req.body.tuition_id;
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
  if (req.body.student_location != null) {
    res.pendingTuition.student_location = req.body.student_location;
  }
  if (req.body.start_time != null) {
    res.pendingTuition.start_time = req.body.start_time;
  }
  if (req.body.end_time != null) {
    res.pendingTuition.end_time = req.body.end_time;
  }
  if (req.body.tutor_bids != null) {
    res.pendingTuition.tutor_bids = req.body.tutor_bids;
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
    await res.pendingTuition.remove();
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
router.put('/:id/bid', getPendingTuition, async (req, res) => {
  const { tutor_id, bid } = req.body;
  const existingPendingTuition = res.pendingTuition;

  // Check if the tutor has already placed a bid
  const existingBidIndex = existingPendingTuition.tutor_bids.findIndex(bidObj => bidObj.tutor_id === tutor_id);
  if (existingBidIndex !== -1) {
    // Update the existing bid if it exists
    existingPendingTuition.tutor_bids[existingBidIndex].bid = bid;
  } else {
    // Add a new bid to the tutor_bids array if the tutor has not placed a bid yet
    existingPendingTuition.tutor_bids.push({ tutor_id, bid });
  }

  try {
    const updatedPendingTuition = await existingPendingTuition.save();
    res.json(updatedPendingTuition);
  } catch (err) {
    res.status(400).json({ message: err.message });
  }
});

// start tuition
/* format :{
    start_time: dateandtime
    tutor_id: confirmed tutor id
    tutor_bids: {
        {
            only the bid confirmed here
        }   
    }
}
*/
router.put("/:id/start", getPendingTuition, async (req, res) => {
  const { tutor_id, bid } = req.body;
  const { pendingTuition } = res;

  // Create a new confirmed bid object
  const confirmedBid = { tutor_id, bid };

  // Replace all tutor bids with the confirmed bid
  pendingTuition.tutor_bids = [confirmedBid];

  // Set the confirmed tutor ID and start time
  pendingTuition.tutor_id = tutor_id;
  pendingTuition.start_time = new Date();

  await pendingTuition.save();

  res.status(200).json({ message: "Pending tuition started successfully" });
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
