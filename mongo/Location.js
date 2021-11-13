const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const Location = new Schema({
    latitude: {
        type: Number
    },
    longitude: {
        type: Number,
    },
    sub_district: {
        type: String,
    },
    district: {
        type: String,
    },
    province: {
        type: String,
    },
    postal_code:{
        type: String
    }
}) 

/**
 * Latitude
 * Longitude
 * Sub-district
 * district
 * province
 * postal_code
 */