var promotionModel = require('../../models/promotion.model');
var express = require('express');
var moment = require('moment');
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

router.post('/add', (req, res) => {
    var entity = req.body;
    var dateExpire = entity.HanSuDung;
    var dateAplly = entity.NgayApDung;
    dateExpire = moment(dateExpire).format("YYYY/MM/DD");
    dateAplly = moment(dateAplly).format("YYYY/MM/DD");
    entity.HanSuDung = dateExpire;
    entity.NgayApDung = dateAplly;
    promotionModel.add(entity).then(values => {
        console.log('Add success');
        res.redirect('/admin/promotions');
    })
    .catch(err => console.log(err));
})

router.get('/edit', (req, res) => {
    var id = req.query.id;
    promotionModel.findOne(id).then(values => {
        res.render('admin/VwEditPromotion', {layout: '_layouts/main-admin.hbs', entity: values[0], id: values[0].MaGiamGia});
    })
    .catch(err => console.log(err));
})

router.post('/edit', (req, res) => {
    var id = req.query.id;
    promotionModel.findOne(id).then(values => {
        var entity =  req.body;
        entity.MaGiamGia = values[0].MaGiamGia;
        var dateExpire = entity.HanSuDung;
        var dateAplly = entity.NgayApDung;
        dateExpire = moment(dateExpire).format("YYYY/MM/DD");
        dateAplly = moment(dateAplly).format("YYYY/MM/DD");
        entity.HanSuDung = dateExpire;
        entity.NgayApDung = dateAplly;

        //update
        promotionModel.update(entity).then(values => {
            res.redirect('/admin/promotions');
        })
        .catch(err => console.log(err));
    })
    .catch(err => console.log(err));
})
module.exports = router;