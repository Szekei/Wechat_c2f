/**
 * Created by I309908 on 9/14/2015.
 */
var wechat = require('wechat');


exports.subscribe = function(req, res, next) {
    var code = req.params.code;

    res.render('state/state', {});
};