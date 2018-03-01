var Order = require('../models/order.js');
var mongoose = require('mongoose');
var ObjectId = mongoose.Types.ObjectId;

exports.create = function(order){
	order._id = new ObjectId;
	order.createTime = (new Date()).toLocaleString();
	order.userId = new ObjectId(order.userId);
  
  console.log('this is serviece-order.js');
	var newOrder = new Order(order);
	return newOrder.save();
}