const express = require('express');
const testRouter = require('./routes/test');
const mongoRouter = require('./routes/mongo');
const cors = require('cors');
require('dotenv').config()
const mongoose = require('mongoose');


const app = express();

app.use('*', cors({
    origin: 'http://localhost:5000'
}));

app.use(express.json()); 
app.use(express.urlencoded({ extended: false }));

// app.use('/test', testRouter);
app.use('/mongo', mongoRouter);


// connect to mongo before listen
mongoose.connect(process.env.MONGODB, {useNewUrlParser: true, useUnifiedTopology: true })
.then( result => {
    console.log("Connected to mongoose");
    app.listen(3000, () => {
        console.log('Listening to port 3000');
    })
})
