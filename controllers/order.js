var i18n = require('i18n');
var sharingHandler = require('../wechat/sharing.js');
var env = process.env.NODE_ENV || "development";
var config = require('../config/config.json');

exports.new = function(req, res, next) {
  res.render('order/order_new', {});
};

exports.show = function(req, res, next) {
  res.render('order/order_show', {});
};

exports.select = function(req, res, next) {
  //console.log('session.userID:' + req.session.userID);

  var typeIndex = req.query.type;
  var colorIndex = req.query.color;

  res.render('order/order', {
    order_js_src: i18n.__('order_js_src'),
    typeIndex: typeIndex,
    colorIndex: colorIndex,
    headImgUrl: req.query.headImgUrl
  });
};

exports.state = function(req, res, next) {
  var timestamp = sharingHandler.createTimestamp();
  var nonceStr = sharingHandler.createNonceStr();
  var url = req.protocol + '://' + req.hostname + req.url; //????url
  console.log("url: "+ url);
  console.log('session.userID:' + req.session.userID);
  sharingHandler.sign(timestamp, nonceStr, url)
      .then(function(signature) {
        res.render('state/state', {
          appId: config[env].wechat.appID, 
          timestamp: timestamp, 
          nonceStr: nonceStr, 
          signature: signature,
          headImgUrl: req.session.headImgUrl
        });
      })
      
};


exports.sharing = function(req, res, next) {
  var typeArr = ['audi', 'bmw', 'porsche', 'ford', 'chevrolet'];
  var colorArr = ['white', 'orange', 'yellow', 'black', 'red', 'gold', 'silvery'];
  var typeIndex = req.query.type;
  var type = typeArr[typeIndex];
  var colorIndex = req.query.color;
  var color = colorArr[colorIndex];

  var headImgUrl = req.query.headImgUrl;

  var intro1 = type + ' (' + color + ')';
  var imgSrc = 'lib/car/' + type + '_' + color + '.jpg';
  res.render('sharing/sharing', {
    typeIndex: typeIndex,
    colorIndex: colorIndex,
    intro1: intro1,
    imgSrc: imgSrc,
    headImgUrl: headImgUrl
  });
};
exports.anlayse = function(req, res, next) {
  res.render('analyse/display', {display_js_src: i18n.__('display_js_src')});
  }