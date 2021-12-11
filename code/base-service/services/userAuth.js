const jwt = require('jsonwebtoken');

async function generateJWT(userID) {
    jwt.sign({
        data: userID
    }, 'secret' , { expiresIn: '1h' }, (err, token) => {
        if(err){
            throw err;
        }
        console.log(token);
        return token;
    });
}

module.exports = {
    generateJWT
}