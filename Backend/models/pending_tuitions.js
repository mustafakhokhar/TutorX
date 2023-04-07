const mongoose = require("mongoose");
const Schema = mongoose.Schema;

// update tutor_id when tuition is confirmed and bid is selected
// Only the bid selected will be in the tutor bid is confirmed
// start time will also be determined then
const PendingTuitionsSchema = new Schema(
  {
    student_id: { type: String, required: true },
    tutor_id: { type: String},
    topic: { type: String, required: true },
    student_location: {
        type: { type: String, enum: ['Point'], required: true },
        coordinates: { type: [Number], required: true }
      },
    start_time: { type: Date },
    tutor_bids: [
      {
        tutor_id: { type: String, required: true },
        bid_amount: { type: Number, required: true },
      },
    ],
  },
  { timestamps: true }
);
PendingTuitionsSchema.index({ location: '2dsphere' });

module.exports = mongoose.model("pending_tuitions", PendingTuitionsSchema);
