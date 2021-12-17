const express = require('express');
const router = express.Router();
const ger = require('../GER/ger');

/* GET recommendations */
router.get('/user/:id', async function (req, res, next) {
  ger.recommendations_for_person('favorites', req.params.id, {
    actions: { "add_to_fav": 2, "remove_from_fav": -1 } //ggf. anpassen!
  }).then((querry) => {
    let recommendations = querry.recommendations.map((rec) => ({
      artworkid: rec.thing
    })).slice(0, 10);
    recommendations = { userId: req.params.id, recommendations };
    res.send(recommendations)
  });
});

module.exports = router;
