var promotionModel = require('../../models/promotion.model');
var express = require('express');
var router = express.Router();

router.get('/', (req, res) => {
    promotionModel.all().then(rows => {
    res.render('admin/VwPromotion', {layout: '_layouts/main-admin.hbs', list: rows});
    })
    .catch(err => console.log(err));
})

router.get('/delete', (req,res) => {
    var id = req.query.id;
    if (id > 0) {
        promotionModel.delete(id).then(value => {
            console.log('delete success ' + value);
            res.redirect('/admin/promotions');
        })
        .catch(err => console.log(err));
    }
})


module.exports = router;