const mongoose = require("mongoose");
const Schema = mongoose.Schema;

const devicesSchema = new Schema({
    uid: {
        type: String,
        required: true,
        unique: true,
    },
    device: {
        type: String,
        required: true
    },
})

module.exports = mongoose.model('devices', devicesSchema);
