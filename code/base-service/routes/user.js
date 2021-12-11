const express = require('express');
const router = express.Router();
const users = require('../db_connct/query_users');

/*GET auf alle User Ressourcen, nur für Tests*/
router.get('/', async function(req, res, next) {
    try {
        res.status(200).json(await users.getMultiple(req.query.page));
    } catch (error) {
        console.error(`Error while getting user...`, error.message);
        next(error);
    }
});

/* GET auf user Ressource */
router.get('/:id', async (req, res, next) => {
    const id = req.params.id
    try {
        res.status(200).json(await users.getSingleUser(id));
    } catch (error) {
        console.error(`Error while getting user...`, error.message);
        next(error);
    }
});

module.exports = router;