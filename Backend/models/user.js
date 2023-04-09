const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const userSchema = new Schema({
    uid: {
        type: String,
        required: true,
    },
    fullname: {
        type: String,
        required: true
    },
    student: {
        type: Boolean,
        required: true,
    },
    educationLevel: {
        type: String
    }
}, {timestamps: true})

module.exports = mongoose.model('users', userSchema);
