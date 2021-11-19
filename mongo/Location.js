const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const Location = new Schema({
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
    }
}, {timestamps: true}) 

/**
 * Latitude
 * Longitude
 * Sub-district
 * district
 * province
 * postal_code
 */