const express = require('express');
const testRouter = require('./routes/test');

const app = express();

app.use(express.json()); 
app.use(express.urlencoded({ extended: false }));

app.use('/test', testRouter);

app.listen(3000, () => {
    console.log('Listening to port 3000');
})