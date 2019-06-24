var productModel = require('../../models/product.model');
var productDetailModel = require('../../models/product-detail.model');
var express = require('express');
var router = express.Router();
var cateDB = require('../../models/categories.model');
var storageDB = require('../../models/storage.model');
router.get('/', (req, res) => {
    var idCate = req.query.idCate;
    productModel.findAllByIdCate(idCate).then(rows => {
        console.log(rows);
        res.render('admin/manage-product', { layout: '_layouts/main-admin', listProduct: rows });
    }).catch(err => {
        console.log(err);

    });
})
router.get('/add', (req, res) => {
    var c = cateDB.findAll();
    var s = storageDB.findAll();
    Promise.all([c, s]).then(values => {
        res.render('admin/add-product',
            {
                layout: '_layouts/main-admin',
                categories: values[0],
                storage: values[1]
            });
    }).catch(err => {
        console.log(err);

    });
})
router.post("/add", (req, res) => {
    var entityProduct = {
        Ten: req.body.Ten,
        Gia: req.body.Gia,
        TrangThai: 1,
        MaKhoHang: req.body.MaKhoHang,
        MaDanhMuc: req.body.MaDanhMuc
    };
    console.log(entityProduct);
    if (entityProduct) {
        var rs = productModel.addProduct(entityProduct);
        rs.then(row => {
            console.log("Add new post success");
            var entityProductDetail = {
                MaSanPham: row,
                TongSoLuong: req.body.TongSoLuong,
                TongTonKho: 0,
                SoLuongCoTheBan: 0
            }
            productDetailModel.addProductDetail(entityProductDetail).then(row => {
                res.json(entityProduct.MaDanhMuc);
            }).catch(err => {
                console.log('Add product detail failed cause: ' + err);
                res.redirect('/admin/manage-product?idCate=' + entityProduct.MaDanhMuc);
            });
        }).catch(err => {
            console.log('Add new product failed cause: ' + err);
            res.redirect('/admin');
        });

    }
});
router.get("/delete", (req, res) => {
    var id = req.query.id;
    var idCate = req.query.idCate;
    if (id > 0) {
        productDetailModel.deleteProductDetail(id).then(rows => {
            productModel.deleteProduct(id).then(rows => {
                console.log('delete success');
                res.redirect('/admin/manage-product?idCate=' + idCate);
            }).catch(err => {
                console.log(err);
            })
        }).catch(err => {
            console.log(err);
        });
    }

});
router.get('/edit/:id', (req, res) => {
    var id = req.params.id;
    var p = productModel.findById(id);
    var pd = productDetailModel.findById(id);
    var c = cateDB.findAll();
    var s = storageDB.findAll();
    var arrayStatus = [{ value: 1, name: 'Còn hàng' }, { value: 2, name: 'Hết hàng' }];
    Promise.all([p, pd, c, s, arrayStatus]).then(values => {
        console.log(values);
        if (values[2] != null && values[0] != null) {
            for (const item of values[2]) {
                if (item.MaDanhMuc == values[0].MaDanhMuc) {
                    item['selected_1'] = true;
                }
            }
        }
        if (values[3] != null && values[0] != null) {
            for (const item of values[3]) {
                if (item.MaKhoHang == values[0].MaKhoHang) {
                    item['selected_2'] = true;
                }
            }
        }
        if (values[4] != null && values[0] != null) {
            for (const item of values[4]) {
                if (item.value == values[0].TrangThai) {
                    item['selected_3'] = true;
                }
            }
        }
        res.render("admin/edit-product", {
            layout: '_layouts/main-admin',
            product: values[0],
            productDetail: values[1],
            categories: values[2],
            storage: values[3],
            status: values[4]
        });
    }).catch(err => {
        console.log(err);
    });
});
router.post('/edit/:id', (req, res) => {
    var id = req.params.id;
    var entityProduct = productModel.findById(id);
    var entityProductDetail = productDetailModel.findById(id);
    Promise.all([entityProduct, entityProductDetail]).then(values => {
        if (values[0] != null && values[1] != null) {
            var MaDanhMuc = values[0].MaDanhMuc;
            values[0].Ten = req.body.Ten;
            values[0].Gia = req.body.Gia;
            values[0].MaKhoHang = req.body.MaKhoHang;
            values[0].MaDanhMuc = req.body.MaDanhMuc;
            values[0].TrangThai = req.body.TrangThai;
            values[1].TongSoLuong = req.body.TongSoLuong;
            values[1].TongTonKho = req.body.TongTonKho;
            values[1].SoLuongCoTheBan = req.body.SoLuongCoTheBan;

            productModel.update(values[0]).then(rows => {
                productDetailModel.update(values[1]).then(rows => {
                    res.json(MaDanhMuc);
                }).catch(err => { console.log(err); });
            }).catch(err => {
                console.log(err);
            });
        }
    }).catch(err => {
        console.log(err);
    });
});

module.exports = router;