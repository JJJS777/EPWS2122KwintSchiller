const amqp = require('amqplib');
const amqpUrl = process.env.RABBITMQ_URL;

async function sendMsg(dataJson){

    const connection = await amqp.connect(amqpUrl, 'heartbeat=60');
    const channel = await connection.createChannel();

    try {
        console.log('Publishing');
        const exchange = 'user.update_favorite';
        const queue = 'new_favorite';
        const routingKey = 'update_favorite';

        await channel.assertExchange(exchange, 'direct', { durable: true });
        await channel.assertQueue(queue, { durable: true });
        await channel.bindQueue(queue, exchange, routingKey);

        await channel.publish(exchange, routingKey, Buffer.from(JSON.stringify(dataJson)));
        console.log('Message published');

    } catch (e) {
        console.error('Error in publishing message', e);
    } 
    // finally {
    //     console.info('Closing channel and connection if available');
    //     await channel.close();
    //     await connection.close();
    //     console.info('Channel and connection closed');
    // }
    // process.exit(0);
}

module.exports = {sendMsg}
