const env = process.env;

const config = {
  db: {
    host: env.DB_HOST,
    port: env.DB_PORT,
    user: env.DB_USER,
    password: env.DB_PW,
    database: env.DB_NAME
  },
  port: env.PORT,
  amqp_favorite_url: env.RABBITMQ_IS_FAVORITE_URL
};

module.exports = config;
