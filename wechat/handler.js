var express = require('express');
var wechat = require('wechat');
var urlHelper = require('./urlHelper');
var config = require('../config/config.json');
var env = process.env.NODE_ENV || "development";
var https = require('https');

var userService = require('../service/user');

exports.resolveWechatUserId = function(req, res, next) {
	//TODO move code from app.js here
  var authCode = req.query.code;
  var jsonData;

  if(req.session && req.session.userID) {
    console.log('hasSession');
    console.log(req.session.userID);
    console.log(req.session.headImgUrl);
    next();
    return;
  }

  if(authCode) {
    console.log('code:' + authCode);
    //https request to get access_token&openid
    var getAccessTokenUrl = urlHelper.getAccessTokenUrl(authCode);
    var accesstokenReq = https.get(getAccessTokenUrl, function(res) {
      console.log(getAccessTokenUrl);
      res.on('data', function(chunk) {
        jsonData = JSON.parse(chunk);
        console.log('access_token:'+jsonData.access_token);
        console.log('openid:'+jsonData.openid);
        var accessToken = jsonData.access_token;
        var openID = jsonData.openid;

        //https request to get user_info
        var  getUserInfoUrl = urlHelper.getUserInfoUrl(accessToken, openID);
        var infoReq = https.get(getUserInfoUrl,function(res){
          res.on('data', function(chunk){
            var userData = JSON.parse(chunk);
            console.log('headimgurl:'+userData.headimgurl);
            //TODO save the userInfo and get the userID
            userService.findByOpenId(openID)
              .then(function(findRes) {
                console.log('result');
                console.log(findRes);
                if(findRes) {
                  // req.query.userID = findRes._id;
                  req.session.userID = findRes._id;
                  req.session.headImgUrl = findRes.headimgurl;
                  req.query.headImgUrl = findRes.headimgurl;
                  

                  next();
                }
                else {
                  console.log('userData:');
                  console.log(userData);
                  userService.create(userData)
                    .then(function(createRes) {
                      console.log('createRes');
                      console.log(createRes);
                      // req.query.userID = createRes._id;
                      req.session.userID = createRes._id;
                      req.session.headImgUrl = createRes.headimgurl;
                      req.query.headImgUrl = createRes.headimgurl;

                      next();
                    });            
                }
              })
          });
        });
      });
      res.on('end',function(){
        console.log('no more data');
      });
    });
  }
  else {
      res.redirect('https://open.weixin.qq.com/connect/oauth2/authorize?appid=wxd02a571349eedbf6&redirect_uri=http%3a%2f%2f115.29.136.24%2forder%2forder&response_type=code&scope=snsapi_userinfo&state=STATE#wechat_redirect');
//    next();
  }
};

exports.resolveWechatMessage = wechat(config[env].wechat.token, function(req, res, next){
  var message = req.weixin;
  console.log('wechatMessage');
  console.log(message);
  if((message.MsgType === 'event') && (message.Event === 'subscribe'))
  {
    var replyStr = "Thanks for following us on Wechat!" + "\n"+ "Purchase your customized car here, and enjoy!";
    res.reply(replyStr);
  }
  //console.log(message.FromUserName);
  //next();
  if((message.MsgType === 'event') && (message.Event === 'CLICK') && (message.EventKey === 'about_info')){
    var replyStr = "EasyOrder system is a latest C2F platform, wihch combines SAP Manufacturing Execution System and Wechat and gives you experience of C2F and Industry 4.0!" + "\n"+        "You purchase your customized car here, enjoy it!";
    res.reply(replyStr);
  }
  });