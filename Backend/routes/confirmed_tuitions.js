const express = require('express');
const router = express.Router();
const ConfirmedTuitions = require('../models/confirmed_tuitions');
const PendingTuitions = require('../models/pending_tuitions');

// POST /confirmed-tuitions
router.post('/', async (req, res) => {
  try {
    const { _id} = req.body;
    const pendingTuition = await PendingTuitions.findById(_id);
    if (!pendingTuition) {
      return res.status(404).json({ message: 'Pending tuition not found' });
    }
    const duration = (new Date() - pendingTuition.start_time) / 600000; // Duration in minutes
    const bid = pendingTuition.tutor_bids[0].bid_amount;
    if (!bid) {
      return res.status(404).json({ message: 'Tutor bid not found' });
    }
    const confirmedTuition = new ConfirmedTuitions({
      _id,
      tutor_id: pendingTuition.tutor_id,
      student_id: pendingTuition.student_id,
      duration,
      amount: duration * bid
    });
    await confirmedTuition.save();
    await PendingTuitions.findByIdAndDelete(_id);
    return res.status(201).json({ message: 'Tuition confirmed successfully and deleted from pending tuitions' });
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

// GET /confirmed-tuitions
router.get('/', async (req, res) => {
  try {
    const confirmedTuitions = await ConfirmedTuitions.find();
    res.json(confirmedTuitions);
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: 'Server Error' });
  }
});

// GET /confirmed-tuitions/:id
router.get('/:id', getConfirmedTuition, async (req, res) => {
  try {
    res.json(res.confirmedTuition);
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: 'Server Error' });
  }
});

// PUT /confirmed-tuitions/:id
router.put('/:id', getConfirmedTuition, async (req, res) => {
  try {
    const { tutor_id, student_id } = req.body;
    res.confirmedTuition.tutor_id = tutor_id;
    res.confirmedTuition.student_id = student_id;
    await res.confirmedTuition.save();
    res.json({ message: 'Tuition updated successfully' });
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: 'Server Error' });
  }
});

// DELETE /confirmed-tuitions/:id
router.delete('/:id', getConfirmedTuition, async (req, res) => {
  try {
    await res.confirmedTuition.remove();
    res.json({ message: 'Tuition deleted successfully' });
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: 'Server Error' });
  }
});

// Middleware to get the confirmed tuition by id
async function getConfirmedTuition(req, res, next) {
  let confirmedTuition;
  try {
    confirmedTuition = await ConfirmedTuitions.findById(req.params.id);
    if (!confirmedTuition) {
      return res.status(404).json({ message: 'Confirmed tuition not found' });
    }
  } catch (err) {
    console.error(err);
    return res.status(500).json({ message: 'Server Error' });
  }
  res.confirmedTuition = confirmedTuition;
  next();
}

module.exports = router
