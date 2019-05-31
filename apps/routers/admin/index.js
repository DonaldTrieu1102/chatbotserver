var express = require('express');
var router = express.Router();

//middleware
router.use(require("../../middlewares/local.mdw"));

router.use('/manage-product', require('../admin/manage-product'));

router.use('/manage-storage', require('../admin/manage-storage'));


//manage-order
router.use('/orders', require('../admin/order.router'));

router.use('/promotions', require('../admin/promotion.router'));

router.get('/', (req, res) => {
    res.render('admin/VwHome', {layout: '_layouts/main-admin'});
})

module.exports = router;    