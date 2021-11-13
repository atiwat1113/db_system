const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const Customer = new Schema({
    user_id: {
        type: String,
        required: true
    },
    first_name: {
        type: String,
        required: true
    },
    last_name: {
        type: String,
        required: true
    },
    phone_num: {
        type: String,
        required: true,
        unique: true
    },
    email: {
        type: String,
        required: true,
        unique: true
    },
    username: { 
        type: String,
        required: true,
        unique: true
    },
    password: {
        type: String,
        required: true
    },
    default_payment: {
        type: String,
        enum: ['cash', 'card', 'bank'] // may be changed
    },
    saved_address: [{
        name: String,
        location_id: String//ref something
    }],
    card: [{
        card_num: String,
        expire: String,
        cvv: String
    }]
}, {timestamps: true})
/**
 * User_id
 * first_name
 * last_name
 * phone_num
 * email
 * username
 * password
 * default_payment
 * 
 * Card ??
 * 
 * Saved Addr
 *  - name
 *  - Location
 * 
 * Location
 * Location_id
 * Latitude
 * Longitude
 * Sub-district
 * district
 * province
 * postal_code

 */