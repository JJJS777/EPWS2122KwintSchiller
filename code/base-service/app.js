'use strict';

const express = require('express');
const app = express();
const port = process.env.PORT;
const { Client } = require("pg");
const http = require('http');

const loadArtwork = require('./db_connct/db_artworks');

const indexRouter = require('./routes/index');
const userRouter = require('./routes/user');
const artworkRouter = require('./routes/artwork');
const favoriteRouter = require('./routes/favorite');

//Verbindung zur DB aufbauen
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

app.use(express.json());

/**Artworks über APi ziehen und in DB speichern */
loadArtwork.insertArtwork();

app.use('/', indexRouter);
app.use('/user', userRouter);
app.use('/artwork', artworkRouter);
app.use('/favorite', favoriteRouter);

//Server erzeugen
const server = http.createServer(app);

server.listen(port, () => {
  console.log(`Example app listening at http://localhost:${port}`)
});

module.exports = app;
