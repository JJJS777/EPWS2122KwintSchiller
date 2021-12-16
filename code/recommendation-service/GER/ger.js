const config = require('../config');

const g = require('ger');
const knex = new g.knex({ "client": "pg", "connection": config.db });
const esm = new g.PsqlESM({ knex: knex });
const ger = new g.GER(esm);

ger.initialize_namespace('favorites').catch((err) => console.warn(err));

module.exports = ger;
