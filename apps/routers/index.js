var express = require('express');
var router = express.Router();


//middleware
// router.use(require("../middlewares/local.mdw"));

//router admin
router.use("/admin", require('./admin/index'));

module.exports = router;