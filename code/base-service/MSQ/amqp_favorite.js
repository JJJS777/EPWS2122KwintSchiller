const amqpUrl = process.env.RABBITMQ_URL;
const open = require('amqplib').connect(amqpUrl);
//ms queue
const newFavoQueue = 'new_favorite';

// const ch = open.then((conn) => {
//     return conn.createChannel();
// });

// // Publisher
// function publisher(dataJson, actionparam) {

//     console.log('Publishing');
//     const exchange = 'user.update_favorite';
//     const routingKey = 'update_favorite';

//     msg = [{
//         userid: dataJson.userid,
//         action: actionparam,
//         artworkid: dataJson.artworkid
//     }]

//     // const options = {
//     //     persistent: true,
//     //     noAck: false,
//     //     timestamp: Date.now(),
//     //     contentEncoding: "utf-8",
//     //     contentType: "application/json"
//     // };

//     console.log(msg);

//     try {
//         ch.assertQueue(newFavoQueue, { durable: true });
//         ch.bindQueue(newFavoQueue, exchange, routingKey);
//         ch.publish(exchange, routingKey, Buffer.from(msg));
//         console.log('Message published');
//     } catch (error) {
//         console.error('Error in publishing message', error);
//     }

// }




const amqp = require('amqplib');
async function pubFav(dataJson, actionparam) {

    const connection = await amqp.connect(amqpUrl, 'heartbeat=60');
    const channel = await connection.createChannel();

    try {
        console.log('Publishing');
        const exchange = 'user.update_favorite';
        const routingKey = 'update_favorite';
    
        msg = [{
            userid: dataJson.userid,
            action: actionparam,
            artworkid: dataJson.artworkid
        }]

        console.log(msg);

        await channel.assertExchange(exchange, 'direct', { durable: true });
        await channel.assertQueue(newFavoQueue, { durable: true });
        await channel.bindQueue(newFavoQueue, exchange, routingKey);

        await channel.publish(exchange, routingKey, Buffer.from(JSON.stringify(msg)));
        console.log('Message published');

    } catch (e) {
        console.error('Error in publishing message', e);
    }
    finally {
        console.info('Closing channel and connection if available');
        await channel.close();
        await connection.close();
        console.info('Channel and connection closed');
    }
    process.exit(0);
}

module.exports = { 
    pubFav
 }
