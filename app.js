var express = require('express');
var path = require('path');
var favicon = require('serve-favicon');
var logger = require('morgan');
var cookieParser = require('cookie-parser');
var bodyParser = require('body-parser');
var i18n = require('i18n');
var i18nDebug = require('debug')('i18n');

var webRouter = require('./web_router');
var apiRouter = require('./api_router_v1');
var wechatHandler = require('./wechat/handler.js');
var http = require('http');
var session = require('express-session');
var order = require('./controllers/order');

var app = express();
var mongoose = require('mongoose');
var insertdata = require('./test/index');

var config = require('./config/config.json');
var env = process.env.NODE_ENV || "development";
var use_db = process.env.USE_DB || config[env].mongodb.USE_DB;
if('false'!==use_db){
	var mongoose = require('mongoose');
	var db_address = config[env].mongodb.ip;
	var db_name = config[env].mongodb.dbname;
	var connect = "mongodb://"+db_address+"/"+db_name;
	mongoose.connect(connect);
/* //check if database is connected
  var db = mongoose.connection;
  db.on('error', console.error.bind(console, 'connection error:'));
  db.once('open', function() {
  // we're connected!
  console.log('db connected!');  
});*/
}

var acceptLanguage = ['zh','en'];
//configure i18n

if('test' === env) {
	insertdata.insert();
}

i18n.configure({
	  // setup some locales - other locales default to en silently
	  locales: acceptLanguage,
	 
	  // sets a custom cookie name to parse locale settings from
	  //cookie: 'i18nForMFGIndustry40',
	  
	  //disabled update i18n json files
	  updateFiles: false,
	 
	  // where to store json files - defaults to './locales'
	  directory: __dirname + '/locales'
});


// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'jade');

// uncomment after placing your favicon in /public
//app.use(favicon(path.join(__dirname, 'public', 'favicon.ico')));
app.use(logger('dev'));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));

app.use(session({
  secret: 'secret',
  resave: true,
  saveUninitialized: true
}));

app.use(i18n.init);
i18nDebug('i18n init, acceptLanguage including %s',acceptLanguage.toString());
app.use(function(req,res,next){
	var lang = req.acceptsLanguages(acceptLanguage);
	var ip = req.ip;
	i18nDebug("IP: "+ip+' prefered language: ' + lang);
	next();
});

//app.use(function(req, res, next) {
//  var authCode = req.query.code;
//  var jsonData;
//  var userID = 0;
//  var getAccessTokenUrl = 'https://api.weixin.qq.com/sns/oauth2/access_token?appid=wxd02a571349eedbf6&secret=09cf12b57c6c3b08e35772cf74cabc1a&code='+authCode+'&grant_type=authorization_code';
//
//  if(authCode) {
//    //https request to get access_token&openid
//    var accesstokenReq = https.get(getAccessTokenUrl,function(res) {
//        res.on('data', function(chunk) {
//          jsonData = JSON.parse(chunk);
//        console.log('access_token:'+jsonData.access_token);
//        console.log('openid:'+jsonData.openid);
//
//        //https request to get user_info
//          var  getUserInfoUrl = 'https://api.weixin.qq.com/sns/userinfo?access_token='+jsonData.access_token+'&openid='+jsonData.openid+'&lang=zh_CN';
//          var infoReq = https.get(getUserInfoUrl,function(res){
//            res.on('data', function(chunk){
//              var userData = JSON.parse(chunk);
//              console.log('headimgurl:'+userData.headimgurl);
//
//             //TODO save the userInfo and get the userID
//              req.query.userID = userID;
//              next();
//            });
//          });
//      });
//      res.on('end',function(){
//        console.log('no more data');
//      });
//    });
//  }
//
//});
app.use('/wechat', wechatHandler.resolveWechatMessage);
app.use('/sharing',order.sharing);
app.use('/', wechatHandler.resolveWechatUserId);
app.use('/', webRouter);  
app.use('/api/v1', apiRouter);



app.use(express.query());

//var env = process.env.NODE_ENV || "development";
//if('test' === env) {

//}

// catch 404 and forward to error handler
app.use(function(req, res, next) {
  var err = new Error('Not Found');
  err.status = 404;
  next(err);
});

// error handlers

// development error handler
// will print stacktrace
if (app.get('env') === 'development') {
  app.use(function(err, req, res, next) {
    res.status(err.status || 500);
    res.render('error', {
      message: err.message,
      error: err
    });
  });
}

// production error handler
// no stacktraces leaked to user
app.use(function(err, req, res, next) {
  res.status(err.status || 500);
  res.render('error', {
    message: err.message,
    error: {}
  });
});


module.exports = app;
