const dbQuery = require('./db_query');
const helper = require('./db_helper');
const config = require('./db_config');

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


module.exports = {
    create,
}