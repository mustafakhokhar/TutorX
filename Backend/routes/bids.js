const express = require("express");
const router = express.Router();
const bidsModel = require("../models/bids");

// GET all bids
router.get("/", async (req, res) => {
  try {
    const bids = await bidsModel.find();
    res.json(bids);
  } catch (err) {
    res.json({ message: err });
  }
});

// GET a specific bid by ID
router.get("/:id", async (req, res) => {
  try {
    const bid = await bidsModel.find({student_id: req.params.id});
    res.json(bid);
  } catch (err) {
    res.json({ message: err });
  }
});

// POST a new bid
router.post("/", async (req, res) => {
  const bid = new bidsModel({
    tuition_id: req.body.tuition_id,
    student_id: req.body.student_id,
    tutor_id: req.body.tutor_id,
    tutor_name: req.body.tutor_name,
    bid_amount: req.body.bid_amount,
  });

  try {
    const savedBid = await bid.save();
    res.json(savedBid);
  } catch (err) {
    res.json({ message: err });
  }
});

// UPDATE a bid by ID
router.put("/:id", async (req, res) => {
  try {
    const updatedBid = await bidsModel.findByIdAndUpdate(
      req.params.id,
      { $set: req.body },
      { new: true }
    );
    res.json(updatedBid);
  } catch (err) {
    res.json({ message: err });
  }
});

// DELETE a bid by ID
router.delete("/:id", async (req, res) => {
  try {
    const removedBid = await bidsModel.deleteMany({student_id: req.params.id});
    res.json(removedBid);
  } catch (err) {
    res.json({ message: err });
  }
});

module.exports = router;
