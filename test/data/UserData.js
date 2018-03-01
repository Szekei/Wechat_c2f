var mongoose = require('mongoose');
var ObjectId = mongoose.Types.ObjectId;

var users = [];
module.exports = {
    UserFun: function(){
        for(var k = 0;k<100;k++){
            var b = {
                _id: new ObjectId(100000000000+k+""),
                sex: Math.round(Math.random()) + 1
            };
            //console.log(JSON.stringify(b));
            users.push(b);
        }
        //console.log(users);
    },
    UserObject: users
};