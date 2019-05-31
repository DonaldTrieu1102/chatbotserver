var productModel = require('../../models/product.model');
var express = require('express');
var router = express.Router();

router.get('/', (req, res) => {
    productModel.all().then(rows => {
        res.render('admin/VwProducts', {layout: '__layouts/main-admin', list: rows[0]});
    }).catch();
})

module.exports = router;