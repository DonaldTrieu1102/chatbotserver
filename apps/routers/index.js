var express = require('express');
var router = express.Router();

//router admin
router.use("/admin", require('./admin/index'));

module.exports = router;