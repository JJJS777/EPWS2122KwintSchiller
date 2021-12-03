const express = require('express');
const app = express();
const port = process.env.PORT;
const rabiitmqIsFavoUrl = process.env.RABBITMQ_IS_FAVORITE_URL;
const amqp_isFavo = require('amqplib/callback_api');
const { Client } = require("pg");

const client = new Client({
  user: process.env.DB_USER,
  host: process.env.DB_HOST,
  database: process.env.DB_NAME,
  password: process.env.DB_PW,
  port: process.env.DB_PORT,
});

client.connect(err => {
  if (err) {
    console.error('connection error', err.stack)
  } else {
    console.log('connected')
  }
});

amqp_isFavo.connect(rabiitmqIsFavoUrl, (error0, connection) => {
  if (error0) {
    throw error0;
  }
  connection.createChannel((error1, channel) =>{});
});

app.listen(port, () => {
  console.log(`Example app listening at http://localhost:${port}`)
});
