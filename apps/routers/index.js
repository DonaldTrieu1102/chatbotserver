var express = require('express');
var router = express.Router();


//middleware
// router.use(require("../middlewares/local.mdw"));

//router admin
router.use("/admin", require('./admin/index'));
router.use('/login', require('./login.router'));

router.use("/", require('./fanpage/index'));



module.exports = router;