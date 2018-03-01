var Order = require('../models/order.js');
var User = require('../models/user.js');
var orders = require('../test/data/OrderData.js');
var users = require('../test/data/UserData.js');
module.exports = {
    insert: function(){
        Order.remove({}, function(err) {
            if (!err) {
                console.log('remove order successfully');
            }
            else {
                console.log(err);
            }
        });
        User.remove({}, function(err) {
            if (!err) {
                console.log('remove user successfully');
            }
            else {
                console.log(err);
            }
        });
/*        orders.OrderFun();
        Order.collection.insert(orders.OrderObject, onInsert);
        users.UserFun();
        User.collection.insert(users.UserObject, onInsert);*/
    }
};
function onInsert(err, docs) {
    if (err) {
        console.log('insert err' + err);
    } else {
        console.log('orders or users were successfully stored.', docs.length);
    }
}