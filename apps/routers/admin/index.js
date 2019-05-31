var express = require('express');
var router = express.Router();

// router.use('/manage-products', require('./product.router'));

//manage-order
router.use('/orders', require('./order.router'));

router.use('/promotions', require('./promotion.router'));

router.get('/', (req, res) => {
    res.render('admin/VwHome', {layout: '_layouts/main-admin'});
})

module.exports = router;    