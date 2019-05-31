var express = require('express');
var router = express.Router();
var orderModel = require('../../models/order.model');
var orderDetailModel = require('../../models/order.detail.model');
var productModel = require('../../models/product.model');
var transportModel = require('../../models/transport.model');
var categoryModel = require('../../models/category.model');
var wareHouseModel = require('../../models/wareHouse.model');

router.get('/', (req, res) => {
    orderModel.all().then(rows => {
        res.render('admin/VwOrder', {layout: '_layouts/main-admin', list: rows});
    })
    .catch(err => console.log(err));
})

router.get('/add', (req, res) => {
    Promise.all([
        productModel.all(),
        wareHouseModel.all()
    ])
    .then(values => {
        res.render('admin/VwNewOrder', {layout: '_layouts/main-admin', 
        products: values[0], 
        wareHouses: values[1]
    });
    })
    .catch(err => console.log(err));
})

router.post('/add', (req, res) => {
    var entity = req.body.form;
    var products = JSON.parse(req.body.products);
    var order = {"TenKhachHang": entity.TenKhachHang, "SDTKhachHang": entity.SDTKhachHang, "DiaChiKhachHang": entity.DiaChiKhachHang};

    orderModel.add(order).then(values => {
        res.redirect('/admin/orders');

        for (var i = 0; i < products.length; i++) {
            console.log(products[i].amount);
            var orderDetail = {"MaHoaDon" : values, "MaSanPham": products[i].code, "SoLuongSP" : products[i].amount};
            orderDetailModel.add(orderDetail).then().catch(err => console.log(err));
        }

        res.status(200);
    }).catch(err => console.log(err));
})

//delete
router.get('/delete', (req, res) => {
    var id = req.query.id;
    orderModel.delete(id).then(value => {
        res.redirect('/admin/orders');
    })
    .catch(err => {
        console.log(err);
        res.redirect('/admin/orders');
    })
})

//edit
router.get('/edit', (req, res) => {
    var id = req.query.id;
    console.log(req.query);
    Promise.all([orderModel.findOne(id),
        orderDetailModel.findAllByOrderId(id)],
   )
    .then(values => {
        console.log(values);
        res.render('admin/VwEditOrder', {layout: '_layouts/main-admin', entity: values[0][0], products: values[1]});
    })
    .catch(err => console.log(err));
});

router.get('/detail', (req, res) => {
    var id = req.query.id;
    Promise.all([orderModel.findOne(id),
    orderDetailModel.findAllByOrderId(id)])
    .then(values => {
        res.render('admin/VwOrderDetail', {layout: '_layouts/main-admin', entity: values[0][0], products: values[1]});
    })
})
module.exports = router;