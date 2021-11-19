const express = require('express');
const router = express.Router();
const db = require('../database');

router.get('/', (req, res) => {
    res.send('rider database');
})

router.get('/info', async (req, res) => {

    const { stationName } = req.query

    try {
        const result = await db.promise().query(`
        CALL GetRiderFromStation('${stationName}');
        `);
        res.status(200).send(result[0]);
    }
    catch (err) {
        console.log(err);
    }
})

router.patch('/station', async (req, res) => {

    const { station_ID } = req.body;
    const user_ID = 'UID00002';
    
    try {
        await db.promise().execute(`
        CALL UpdateRiderStation('${user_ID}','${station_ID}');
        `);
        res.status(200).end();
    }
    catch (err) {
        console.log(err);
    }

})

module.exports = router;