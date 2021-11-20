const express = require('express');
const Location = require('../mongo/Location');
const Customer = require('../mongo/Customer');
const customer = require('./customer');

const router = express.Router();

router.post('/', async (req, res) => {
    console.log('req:', req.body)
    const user_id = "UID00007"; // hard-coded
    const { lat, long, sub_district, district, province, postal_code, name } = req.body;
    const latitude = parseFloat(lat);
    const longitude = parseFloat(long);
    
    const location = await Location.findOne({ latitude: latitude, longitude: longitude }).exec();
    console.log('location:',location)
    

    if(location){ // location already exists
        //* CASE 1: the user already added this location -> update user's saved_address name
        if(location.saved_by.some(e => e.user_id === user_id)){
            console.log('case 1')
            Customer.findOne({ user_id: user_id })
            .then(async customer => {
                customer.saved_address.forEach(addr => {
                    if(addr.location_id == location._id){
                        addr.name = name;
                    }
               })
               await customer.save();
            })
            .catch(err => {
                console.log('case 1 error:', err);
                res.status(500).end();
            })
            res.status(200).end()
        }
        //* CASE 2: the user haven't added this location -> update saved_by & add to saved_address
        else{
            console.log('case 2');
            try{
                const newAddr = { name: name, location_id: location_id };
                await Location.updateOne({ latitude: latitude, longitude: longitude }, { $push: { saved_by: {user_id: user_id} } });
                await Customer.updateOne({ user_id: user_id }, { $push: { saved_address: newAddr } });
                res.status(200).end();
            }
            catch (err) {
                console.log('case 2 error:', err);
                res.status(500).end();
            }
        }
    }
    //* CASE 3: location not exist -> create one
    else{
        console.log('case 3')
        const newLocation = new Location({
            latitude,
            longitude,
            sub_district,
            district,
            province,
            postal_code,
            saved_by: [{ user_id: user_id }]
        });
        try{
            const result = await newLocation.save();
            const newAddr = { name: name, location_id: result._id };
            await Customer.updateOne({ user_id: user_id }, { $push: { saved_address: newAddr } });
            res.status(200).end();
        }
        catch (err){
            console.log('case 3 error:', err);
            res.status(500).end();
        }
    }
    console.log('==============')
})
module.exports = router;