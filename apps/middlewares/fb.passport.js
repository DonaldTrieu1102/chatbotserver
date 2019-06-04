var passport = require('passport');
var FacebookStrategy = require('passport-facebook').Strategy();
var userModel = require('../models/user.model');

module.exports = function(app) {
    app.use(passport.initialize());
    app.use(passport.session());

    passport.use(new FacebookStrategy({
        clientID: 123,
        clientSecret: 123,
        callbackURL: "/auth/facebook/callback"
      },
      function(accessToken, refreshToken, profile, cb) {
        userModel.findUserFacebookId({ facebookId: profile.id }, function (err, user) {
          return cb(err, user);
        });
      }
    ));
}