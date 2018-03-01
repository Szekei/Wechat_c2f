var mongoose = require('mongoose');
var Schema = mongoose.Schema;

var Order = new Schema({
  _id: Schema.Types.ObjectId,
  erpOrderId: Number,
  createTime: String,
  priority: Number,
  userId: Schema.Types.ObjectId,
  car: {
	  type: {
		  type: Number,
		  require: true
	  },
	  color: {
		  type: Number,
		  require: true
	  }
  }
});

module.exports = mongoose.model('Order', Order);