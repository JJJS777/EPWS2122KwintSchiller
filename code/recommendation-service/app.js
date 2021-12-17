const cookieParser = require('cookie-parser');
const express = require('express');
const app = express();

const config = require('./config');
const indexRouter = require('./routes/index');
const recommendationsRouter = require('./routes/recommendation');

app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());

app.use('/', indexRouter);
app.use('/recommendations', recommendationsRouter);

app.listen(config.port, () => {
  console.log(`Recommendation-service listening at Port: ${config.port}`)
});

require('./MSQ/amqp_favorites');