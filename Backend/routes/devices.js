const express = require("express");
const router = express.Router();
const devicesModel = require("../models/devices");

// GET all devices
router.get("/", async (req, res) => {
  try {
    const devices = await devicesModel.find();
    res.json(devices);
  } catch (err) {
    res.json({ message: err });
  }
});

// GET a specific device by uid
router.get("/:uid", async (req, res) => {
  try {
    const device = await devicesModel.findOne({ uid: req.params.uid });
    res.json(device);
  } catch (err) {
    res.json({ message: err });
  }
});

// POST a new device
router.post("/", async (req, res) => {
  const device = new devicesModel({
    uid: req.body.uid,
    device: req.body.device,
  });
  try {
    const savedDevice = await device.save();
    res.json(savedDevice);
  } catch (err) {
    res.json({ message: err });
  }
});

// PUT (update) an existing device by uid
router.put("/:uid", async (req, res) => {
  try {
    const updatedDevice = await devicesModel.updateOne(
      { uid: req.params.uid },
      { $set: { device: req.body.device } }
    );
    res.json(updatedDevice);
  } catch (err) {
    res.json({ message: err });
  }
});

// DELETE a specific device by uid
router.delete("/:uid", async (req, res) => {
  try {
    const removedDevice = await devicesModel.deleteOne({ uid: req.params.uid });
    res.json(removedDevice);
  } catch (err) {
    res.json({ message: err });
  }
});

module.exports = router;
