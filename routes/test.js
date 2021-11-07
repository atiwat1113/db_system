const express = require('express');
const router = express.Router();
const db = require('../database');

router.get('/', (req, res) => {
    res.send('test database');
})

router.get('/boat', async (req, res) => {
    try {
        const result = await db.promise().query(`
        SELECT *
        FROM boat
        `);
        res.status(200).send(result[0]);
    }
    catch (err) {
        console.log(err);
    }
})

module.exports = router;