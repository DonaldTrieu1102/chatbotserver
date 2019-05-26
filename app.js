var express = require("express");
var config = require('config');
var bodyParser = require("body-parser");
var session = require('express-session');
var passport = require('passport');
var morgan = require('morgan');
var app = express();
var flash = require("connect-flash");
var index = require(__dirname + "/apps/routers")
var exphbs = require('express-handlebars');

app.use(morgan('dev'));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));
app.use(session({
  secret: config.get('secret_key'),
  resave: true,
  saveUninitialized: true
}));

app.use(flash());
app.use(passport.initialize());
app.use(passport.session());
app.use((req, res, next) => {
  res.locals.currentUser = req.user;
  res.locals.success = req.flash('success');
  res.locals.error = req.flash('error');
  next();
});


//static folder
app.use(express.static(__dirname + "/publics"));

//set up engine 

//set up engine 
app.set("views", __dirname + "/apps/views")
app.set("view engine", "hbs");
var handlebars = require("express-handlebars").create({
  extname: 'hbs',
  defaultLayout: 'index',
  layoutsDir: __dirname + "/apps/views"
});
app.engine('hbs', handlebars.engine);

//set moment helper for handlebars
var Handlebars = require("handlebars");
var MomentHandler = require("handlebars.moment");
MomentHandler.registerHelpers(Handlebars);

app.use('/', index);

var port = config.get("server.port");
app.listen(process.env.PORT || port, function () {
  console.log("Server is running on port: ", port);
});
