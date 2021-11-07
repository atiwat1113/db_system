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
        select u.first_name, u.last_name, r.ref_no, r.is_available, r.rating
        from user u 
        natural join rider r 
        natural join station s
        where s.name = ${stationName};

        `);
        res.status(200).send(result[0]);
    }
    catch (err) {
        console.log(err);
    }
})

module.exports = router;