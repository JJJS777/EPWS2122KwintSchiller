const dbQuery = require('./db_query');
const helper = require('./db_helper');
const config = require('./db_config');

/** Favorite anlegen */
async function create(favorite){
    const result = await dbQuery.query(
        'INSERT INTO favorites(userID, artworkID ) VALUES ($1, $2 ) RETURNING *',
        [ favorite.userid, favorite.artworkid ]
    )
    let message = 'Error adding to Favorite';

    if(result.length){
        message = `Artwork with ID: ${result[0].artworkid} added to Favorites ${result[0].addad}`;
    }

    return {message};
}

/** Liefert alle Favoriten eines Users aus */
async function getMultiple(userId){
    const rows = await dbQuery.query(
        'SELECT userID, artworkID, title, artist, primaryImage FROM favorites NATURAL JOIN artworks WHERE userID = $1;',
        [ userId ]
    );
    const data = helper.emptyOrRows(rows);
    return data
}

/** Liefert eine bestimmtes favorisierte Bild aus */
async function getSingle(userId, artworkId){
    const rows = await dbQuery.query(
        'SELECT userID, artworkID, title, artist, primaryImage FROM favorites NATURAL JOIN artworks WHERE userID = $1 AND artworkID = $2;',
        [ userId, artworkId ]
    );
    const data = helper.emptyOrRows(rows);
    return data
}

module.exports = {
    create,
    getMultiple,
    getSingle
}