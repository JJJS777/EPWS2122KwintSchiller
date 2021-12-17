const config = require('../config');
const ger = require('../GER/ger');

//msq
const newFavorite = 'new_favorite';

const bail = (err) => {
    console.error(err);
    process.exit(1);
  };

const consumer = (conn) => {
    var ok = conn.createChannel(on_open);

    function on_open(err, ch){
        if (err != null) bail(err);
        ch.assertQueue(newFavorite);

        ch.consume(newFavorite, function(msg){
            if (msg !== null ){
                const message = JSON.parse(msg.content.toString());
                console.log('consuming');
                console.log(message);

                ger.events([
                    {
                        namespace: 'favorites',
                        person: message.userid,
                        action: message.action, //-> aus dem Event der msq checken, ob es sich um hinzufügen oder entfernen handelt (add_to_fav oder remove_from_fav )
                        thing: message.artworkid,
                        expires_at: '2050-01-01'
                    }])
                    .then(() => {
                        return ger.recommendations_for_person('favorites', message.userid, {
                            actions: {  "add_to_fav": 2, "remove_from_fav": -1  } //ggf. anpassen
                        });
                    })
                    .then((recommendations) => {
                        console.log(recommendations);
                        if(recommendations.recommendations.length > 0){
                            console.log('hier ggf. notification implementieren')
                        }
                    })
                    .then(() => {
                        ch.ack(msg);
                    })
            }
        });
    }
};

require('amqplib/callback_api')
  .connect(config.amqp_favorite_url, function (err, conn) {
    if (err != null) bail(err);
    consumer(conn);
});
