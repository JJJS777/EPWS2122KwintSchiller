const getData = require('../services/apiMET');
const dbQuery = require('./db_query');
const helper = require('./db_helper');
const config = require('./db_config');

async function insertArtwork() {
    
    const artworkListJSON = await getData.getMETData();

    //console.log(artworkListJSON[0].constituents[0].name)

    artworkListJSON.forEach ( async aw => {
        try {
            await dbQuery.query(
                'INSERT INTO artworks( title, year, artist, objectName, classification, medium, dimensions, country, primaryImage ) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9 ) RETURNING artworkID',
                [aw.title, aw.accessionYear, aw.constituents[0].name, aw.objectName, aw.classification, aw.medium, aw.dimensions, aw.country, aw.primaryImage ]
            )
        } catch (err) { 
            console.log(err);
        }
    });

}

async function getMultipleArtworks(page = 1) {
    const offset = helper.getOffset(page, config.listPerPage);
    const rows = await dbQuery.query(
        'SELECT * FROM artworks OFFSET $1 LIMIT $2',
        [offset, config.listPerPage]
    );
    const data = helper.emptyOrRows(rows);
    const meta = { page };

    return {
        data,
        meta
    }
}

async function getSingleArtwork(id) {
    const rows = await dbQuery.query(
        'SELECT * FROM artworks WHERE artworkID = $1',
        [id]
    );

    const data = helper.emptyOrRows(rows);
    return data;
}


module.exports = {
    insertArtwork,
    getMultipleArtworks,
    getSingleArtwork
}