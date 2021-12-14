const axios = require('axios');

async function getMETData() {

    var artworkArray = []

    for (var obId = 430000; obId < 430003; obId ++) {
        var apiUrl = 'https://collectionapi.metmuseum.org/public/collection/v1/objects/' + obId;
        try {
            const response = await axios.get(apiUrl);
            artworkArray.push( response.data )
        } catch (error) {
            console.error(error);
        }
    }
    return artworkArray;
}

module.exports = {
    getMETData
}