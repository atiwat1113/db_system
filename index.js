const express = require('express');
const testRouter = require('./routes/test');
const cors = require('cors');
require('dotenv').config()
const mongoose = require('mongoose');

mongoose.connect(process.env.MONGODB);

const app = express();

app.use('*', cors({
    origin: 'http://localhost:3000'
}));

app.use(express.json()); 
app.use(express.urlencoded({ extended: false }));

app.use('/test', testRouter);

app.listen(8080, () => {
    console.log('Listening to port 8080');
})