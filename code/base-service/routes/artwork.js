const { request } = require('express');
const express = require('express');
const router = express.Router();
const db_artworks = require('../db_connct/db_artworks')

/*GET auf alle artwork Ressourcen */
router.get('/', async function(req, res, next) {
    try {
        res.status(200).json(await db_artworks.getMultipleArtworks(req.query.page));
    } catch (error) {
        console.error(`Error while getting Artworks...`, error.message);
        next(error);
    }
});


/* GET auf Artwork Ressource */
router.get('/:id', async (req, res, next) => {
    const id = req.params.id
    try {
        res.status(200).json(await db_artworks.getSingleArtwork(id));        
    } catch (error) {
        console.error(`Error while getting Artwork...`, error.message);
        next(error);
    }
});

module.exports = router;