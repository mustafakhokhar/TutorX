const mongoose = require("mongoose");
const Schema = mongoose.Schema;

const bidsSchema = new Schema({
  tuition_id: {
    type: String,
    required: true,
  },
  student_id: {
    type: String,
    required: true,
  },
  tutor_id: {
    type: String,
    required: true,
  },
  tutor_name: {
    type: String,
    required: true,
  },
  bid_amount: {
    type: Number,
    required: true,
  },
});

module.exports = mongoose.model("bids", bidsSchema);





