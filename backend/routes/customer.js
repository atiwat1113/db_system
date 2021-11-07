const express = require('express');
const router = express.Router();
const db = require('../database');

router.get('/', (req, res) => {
    res.send('customer database');
});

router.post('/cards', async (req, res) => {

    const { card_number, card_holder_name, expire_date } = req.body;

    try {
        await db.promise().execute(`
        insert into cardinfo values
        ('${card_number}','UID00007','${card_holder_name}','${expire_date}');
        `);
        res.status(200).end();
    }
    catch (err) {
        console.log(err);
    }
});

router.delete('/', async (req, res) => {
    try {
        await db.promise().execute(`
        delete from user
        where user_ID = 'UID00007'
        `);
        res.status(200).end();
    }
    catch (err) {
        console.log(err);
    }
});

router.patch('/saved-address', async (req, res) => {
    
});

module.exports = router;