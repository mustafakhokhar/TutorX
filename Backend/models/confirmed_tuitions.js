const mongoose = require("mongoose");
const Schema = mongoose.Schema;

const ConfirmedTuitionsSchema = new Schema(
  {
    _id: {
      type: Schema.Types.ObjectId,
      required: true,
    },
    tutor_id: {
      type: String,
      required: true,
    },
    tuition_id: {
      type: String,
      required: true,
    },
    student_id: {
      type: String,
      required: true,
    },
    duration: {
      type: Number,
      required: true,
    },
    amount: {
      type: Number,
      required: true,
    },
  },
  { timestamps: true }
);

module.exports = mongoose.model("confirmed_tuitions", ConfirmedTuitionsSchema);
