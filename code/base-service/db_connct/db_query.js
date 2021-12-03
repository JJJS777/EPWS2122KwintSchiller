const { Pool } = require('pg');
const config = require('../db_config');
const pool = new Pool(config.coreServiceDB);

/**
 * Query the database using the pool
 * @param {*} query 
 * @param {*} params 
 * 
 * @see https://node-postgres.com/features/pooling#single-query
 */

async function query(query, params) {
    const { rows, fields } = await pool.query(query, params);
    return rows;
}

module.exports = {
    query
}