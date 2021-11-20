const express = require('express');
const db = require('./database');
const RiderRouter = require('./routes/rider')(db);
const CustomerRouter = require('./routes/customer')(db);
const mongoRouter = require('./routes/mongo');
const cors = require('cors');
require('dotenv').config()
const mongoose = require('mongoose');

const app = express();

app.use('*', cors({
    origin: 'http://localhost:3000'
}));

app.use(express.json()); 
app.use(express.urlencoded({ extended: false }));

app.use('/riders', RiderRouter);
app.use('/customers', CustomerRouter);
app.use('/mongo', mongoRouter);

// connect to mongo before listening
mongoose.connect(process.env.MONGODB, {useNewUrlParser: true, useUnifiedTopology: true })
.then( result => {
    console.log("Connected to mongoose");
    app.listen(8080, () => {
        console.log('Listening to port 8080');
    })
})
