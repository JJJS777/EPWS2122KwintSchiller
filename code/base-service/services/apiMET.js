const axios = require('axios');

async function getMETData() {

    let artworkArray = []
    let objectWithImage = []

    var URLarrayWithImage = 'https://collectionapi.metmuseum.org/public/collection/v1/search?hasImages=true&q=Paintings'
    try {
        const resIds = await axios.get(URLarrayWithImage);
        objectWithImage = resIds.data.objectIDs.slice(-10)
        //console.log(objectWithImage)
    } catch (error) {
        console.error(error);
    }

    for ( var obId in objectWithImage ) {

        //console.log(objectWithImage[obId])
        var apiUrl = 'https://collectionapi.metmuseum.org/public/collection/v1/objects/' + objectWithImage[obId];
        try {
            const response = await axios.get(apiUrl);
            artworkArray.push(response.data)
        } catch (error) {
            console.error(error);
        }
    }
    return artworkArray;
}

module.exports = {
    getMETData
}