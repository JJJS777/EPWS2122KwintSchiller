const express = require('express');
const router = express.Router();
const db_fav = require('../db_connct/db_fav');
const amqp = require('../MSQ/amqp_favorite')

function bail(err) {
    console.error(err);
    process.exit(1);
}

/*neues Werk zu Favorite speichern*/
router.post('/new', async (req, res, next) => {
    try {
        res.json(await db_fav.create(req.body));
    } catch (error) {
        console.error(`Error adding to Favorite`, error.message);
        res.status(400).send(error);
    }
    //in msq publishen
    amqp.pubFav(req.body, 'add_to_fav');
});

/*Get auf alle gespeicherten Fav. eines Users*/
router.get('/:userid', async (req, res) => {
    const userId = req.params.userid
    try {
        res.status(200).json(await db_fav.getMultiple(userId))
    } catch (error) {
        console.error(`Error while getting Favorites`, error.message);
        res.status(400).send(error);
    }
});

/**GET auf einzelnen Favoriten eines Users */
router.get('/:userid/:artworkid', async (req, res) => {
    const userId = req.params.userid
    const artworkId = req.params.artworkid
    try {
        res.status(200).json(await db_fav.getSingle(userId, artworkId))
    } catch (error) {
        console.error(`Error while getting Favorites`, error.message);
        res.status(400).send(error);
    }
});

/**ggf. noch Delete um Fav. eines Users zu löschen? */

module.exports = router;