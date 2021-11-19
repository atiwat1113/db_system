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
        unique: true,
        minlength: 10,
        maxlength: 10,
        match: /0[0-9]*/  // 0 followed by any 9 digits
    },
    email: {
        type: String,
        required: true,
        unique: true,
        match: /^\w+@[a-zA-Z_]+?(?:.[a-zA-Z])+$/ // anystr@anystr(.anystr)*
    },
    username: { 
        type: String,
        required: true,
        unique: true
    },
    password: { // stores hashed password
        type: String,
        required: true
    },
    default_payment: {
        type: String,
        required: true,
        enum: ['cash', 'bank_transfer', 'credit_card'] // may be changed
    },
    saved_address: [{
        name: String,
        location_id: String
    }],
    card: [{
        card_num: String,
        expire: String,
        cvv: String
    }]
}, {timestamps: true})