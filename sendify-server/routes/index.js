var express = require('express');
var router = express.Router();

/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('index', { title: 'Sendify server' });
});
router.get('/check', function(req, res, next) {
  res.json({msg:"work"})
});
module.exports = router;
