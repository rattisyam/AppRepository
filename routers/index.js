var express = require('express');
var router = express.Router();

var env = process.env.APP_ENV
var ver = process.env.APP_VER

router.get('/', function(req, res) {
  res.render('index', {'env': env ,'ver':ver})
});

module.exports = router;
