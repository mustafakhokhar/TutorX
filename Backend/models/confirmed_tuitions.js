const mongoose = require("mongoose");
const Schema = mongoose.Schema;

const ConfirmedTuitionsSchema = new Schema(
  {
    tuition_id: {
      type: Schema.Types.ObjectId,
      required: true,
      ref: 'PendingTuitions'
    },
    tutor_id: {
      type: Schema.Types.ObjectId,
      required: true,
      ref: 'Tutors'
    },
    student_id: {
      type: Schema.Types.ObjectId,
      required: true,
      ref: 'Students'
    },
    duration: {
      type: Number,
      required: true
    },
    amount: {
      type: Number,
      required: true
    }
  },
  { timestamps: true }
);

module.exports = mongoose.model('ConfirmedTuitions', ConfirmedTuitionsSchema);

