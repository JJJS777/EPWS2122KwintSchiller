const express = require('express');
const router = express.Router();

/* GET index */
router.get('/', function(req, res, next) {
  res.json({message: 'alive'});
});

module.exports = router;
