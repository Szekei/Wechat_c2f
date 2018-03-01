var mongoose = require('mongoose');
var Schema = mongoose.Schema;

var userSchema = new Schema({
	_id: Schema.Types.ObjectId,
	sex: Number,
	openid: String,
	nickname:String,
	province:String,
	city:	String,
	country:String,
	headimgurl:String,
	unionid:String	
});

module.exports = mongoose.model('User',userSchema);