var express = require('express');
var router = express.Router();
var passport = require('passport');
var userModel = require('../models/user.model');

router.get("/", function (req, res) {
    res.render("login", { layout: false });
});

module.exports = router;