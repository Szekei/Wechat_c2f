var express = require('express');
var router = express.Router();
var order = require('./api/v1/order.js');
var analyse = require('./api/v1/analyse.js');
var user = require('./api/v1/user.js');

//test
console.log('this is api-router');
router.post('/user/createUser',user.create);
router.post('/orders',order.create);

router.get('/analyse',analyse.all);

module.exports = router;