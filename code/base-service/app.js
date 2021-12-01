const express = require('express');
const app = express();
const port = process.env.PORT;
const rabiitmqUrl = process.env.RABBITMQ_URL;
const amqp = require('amqplib/callback_api');
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

amqp.connect(rabiitmqUrl, (error0, connection) => {
  if (error0) {
    throw error0;
  }
  connection.createChannel((error1, channel) =>{});
});

app.get('/', (req, res) => {
  res.send('Hello World!')
});

app.listen(port, () => {
  console.log(`Example app listening at http://localhost:${port}`)
});

