var mongoose = require('mongoose');
var ObjectId = mongoose.Types.ObjectId;

var orders = [];
module.exports = {
    OrderFun: function(){
        var order_group = [[1,1],[1,4],[1,5],[2,1],[2,5],[2,6],[3,4],[3,5],[3,7],[4,1],[4,2],[4,7],[5,3],[5,5]];
        var orderObject = new Array(100);
        for(var i = 0;i<100;i++){
            orderObject[i] = order_group[Math.ceil(Math.random()*14)-1];
            //console.log(Math.ceil(Math.random()*14)-1);
        }
        //console.log(JSON.stringify(orderObject));
        for(var o = 0;o<10;o++){
            var a = {createTime: '9/11/2015, 12:27:58 PM',priority: Math.round(Math.random())+1,userId:new ObjectId(100000000000+o+""),car:{type: orderObject[o][0],color: orderObject[o][1]}};
            //console.log(JSON.stringify(a));
            orders.push(a);
        }
        //console.log(orders);
    },
    OrderObject: orders
};