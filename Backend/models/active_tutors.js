const mongoose = require("mongoose");
const Schema = mongoose.Schema;

const ActiveTutorsSchema = new Schema(
  {
    uid: {
      type: String,
      required: true,
    },
    location: {
      type: { type: String, enum: ['Point'], required: true },
      coordinates: { type: [Number], required: true }
    }
  },
  { timestamps: true }
);

ActiveTutorsSchema.index({ location: '2dsphere' });

module.exports = mongoose.model("active_tutors", ActiveTutorsSchema);
