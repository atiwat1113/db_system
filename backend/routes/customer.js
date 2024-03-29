const express = require('express');
const router = express.Router();
const makeID = require('../function');

let db;

router.get('/', (req, res) => {
    res.send('customer database');
});

router.post('/ride-transaction', async (req, res) => {

    const { start_latitude, start_longitude, stop_latitude, stop_longitude, distance, start_time, payment_method } = req.body;

    const customer_ID = 'UID00007';
    const rider_ID = 'UID00002';
    const ride_ID = makeID(8);
    const transaction_ID = makeID(8);
    try {
        await db.promise().execute(`
            CALL addBooking('${ride_ID}',
            '${customer_ID}',
            '${rider_ID}',
            ${start_latitude},
            ${start_longitude},
            ${stop_latitude},
            ${stop_longitude},
            ${distance},
            TIMESTAMP('${start_time}'),
            '${transaction_ID}',
            '${payment_method}'
            )
        `);
        res.status(200).end();
    }
    catch (err) {
        console.log(err);
    }

});

router.delete('/', async (req, res) => {

    const user_ID = 'UID00007';

    try {
        await db.promise().execute(`
        CALL deleteAccount('${user_ID}');
        `);
        res.status(200).end();
    }
    catch (err) {
        console.log(err);
    }
});

module.exports = function (mysqlConnection) {
    db = mysqlConnection;
    return router;
};