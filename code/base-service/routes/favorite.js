const express = require('express');
const router = express.Router();
const db_fav = require('../db_connct/db_fav')

/*neues Werk zu Favorite speichern*/
router.post('/new', async (req, res, next) => {
    try {
        res.json(await db_fav.create(req.body));
    } catch (error) {
        console.error(`Error adding to Favorite`, error.message);
        res.status(400).send(error); 
    }
})


module.exports = router;