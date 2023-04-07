const mongoose = require("mongoose");
const Schema = mongoose.Schema;

// update tutor_id when tuition is confirmed and bid is selected
// Only the bid selected will be in the tutor bid is confirmed
// start time will also be determined then
const PendingTuitionsSchema = new Schema(
  {
    tuition_id: { type: Number, required: true, unique: true },
    student_id: { type: String, required: true },
    tutor_id: { type: String},
    topic: { type: String, required: true },
    student_location: { type: String, required: true },
    start_time: { type: Date },
    end_time: { type: Date },
    tutor_bids: [
      {
        tutor_id: { type: String, required: true },
        bid_amount: { type: Number, required: true },
      },
    ],
  },
  { timestamps: true }
);

module.exports = mongoose.model("pending_tuitions", PendingTuitionsSchema);
