const db = require('./db_query');
const helper = require('./db_helper');
const config = require('../db_config');
const bcrypt = require('bcrypt');

async function getMultiple(page = 1) {
    const offset = helper.getOffset(page, config.listPerPage);
    const rows = await db.query(
        'SELECT userID, user_name, firstname, lastname FROM users OFFSET $1 LIMIT $2',
        [offset, config.listPerPage]
    );
    const data = helper.emptyOrRows(rows);
    const meta = { page };

    return {
        data,
        meta
    }
}

async function getSingleUser(id){
    const rows = await db.query(
        'SELECT userID, user_name, firstname, lastname FROM users WHERE userID = $1',
        [id]
    );

    const data = helper.emptyOrRows(rows);
    return data;
}

async function create(user){

    const salt = await bcrypt.genSalt(10);
    const hashPwd = await bcrypt.hash(user.password, salt);

    const result = await db.query(
        'INSERT INTO users(user_name, firstname, lastname, password) VALUES ($1, $2, $3, $4) RETURNING userID',
        [ user.user_name, user.firstname, user.lastname, hashPwd ]
    );
    let message = 'Error creating quote';

    if(result.length){
        message = `User created with ID: ${result[0].userid} successfully`;
    }

    return {message};
}


async function deleteUser(id){
    await db.query(
        'DELETE FROM users WHERE userID = $1',
        [id],
    );
}

module.exports = {
    getMultiple,
    getSingleUser,
    create,
    deleteUser
}