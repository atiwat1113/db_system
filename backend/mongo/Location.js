const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const locationSchema = new Schema({
    latitude: {
        type: Number,
        required: true,
        min: -90,
        max: 90
    },
    longitude: {
        type: Number,
        required: true,
        min: -180,
        max: 180
    },
    sub_district: {
        type: String,
        required: true,
        minlength: 1,
        maxlength: 50
    },
    district: {
        type: String,
        required: true,
        minlength: 1,
        maxlength: 50
    },
    province: {
        type: String,
        required: true,
        minlength: 1,
        maxlength: 50
    },
    postal_code:{
        type: String,
        required: true,
        minlength: 5,
        maxlength: 5,
        match: /[1-9][0-9]*/
    },
    saved_by: [{ //stores customer who saved the location
        user_id: String
    }],
}, {timestamps: true}) 

locationSchema.index({ latitude: 1, longitude: 1}, { unique: true }); // make (latitude, longitude) unique

module.exports = mongoose.model('Location', locationSchema, 'Location')