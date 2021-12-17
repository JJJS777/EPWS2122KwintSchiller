const amqpUrl = process.env.RABBITMQ_URL;
const open = require('amqplib').connect(amqpUrl);
//ms queue
const newFavoQueue = 'new_favorite';

const amqp = require('amqplib');
async function pubFav(dataJson, actionparam) {

    const connection = await amqp.connect(amqpUrl, 'heartbeat=60');
    const channel = await connection.createChannel();

    try {
        console.log('Publishing');
        const exchange = 'user.update_favorite';
        const routingKey = 'update_favorite';
    
        msg = {
            userid: dataJson.userid,
            action: actionparam,
            artworkid: dataJson.artworkid
        }

        console.log(msg);

        await channel.assertExchange(exchange, 'direct', { durable: true });
        await channel.assertQueue(newFavoQueue, { durable: true });
        await channel.bindQueue(newFavoQueue, exchange, routingKey);

        await channel.publish(exchange, routingKey, Buffer.from(JSON.stringify(msg)));
        console.log('Message published');

    } catch (e) {
        console.error('Error in publishing message', e);
    }
}

module.exports = { 
    pubFav
 }
