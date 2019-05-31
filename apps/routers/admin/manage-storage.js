var express = require("express");
var router = express.Router();
var storageDB = require('../../models/storage.model');

router.get('/', (req, res) => {

    storageDB.findAll().then(rows => {
        console.log(rows);
        res.render('admin/manage-storage', { layout: '_layouts/main-admin', listStorage: rows });
    }).catch(err => {
        console.log(err);

    });
})
router.get('/add', (req, res) => {

    res.render('admin/add-storage', { layout: '_layouts/main-admin', });

})
router.post("/add", (req, res) => {
    var entity = {
        Ten: req.body.Ten,
        DiaChi: req.body.DiaChi,
    };
    if (entity) {
        var rs = storageDB.add(entity);
        rs.then(row => {
            res.json(200);
        }).catch(err => {
            console.log('Add new product failed cause: ' + err);
            res.redirect('/admin/manage-storage');
        });
    }
});
router.get("/delete", (req, res) => {
    var id = req.query.id;
    if (id > 0) {
        storageDB.delete(id).then(rows => {
            console.log('delete success');
            res.redirect('/admin/manage-storage');
        }).catch(err => {
            console.log(err);
        });
    }
});

router.get('/edit/:id', (req, res) => {
    var id = req.params.id;
    var s = storageDB.findById(id);
    s.then(row =>{
        res.render("admin/edit-storage", {
            layout: '_layouts/main-admin',
            storage: row,
        });
    }).catch(err =>{
        console.log(err);      
    });
});
router.post('/edit/:id', (req, res) => {
    var id = req.params.id;
    var entity = storageDB.findById(id);
    console.log(req.body.Ten);
    entity.then(entity =>{
        entity.Ten = req.body.Ten;
        entity.DiaChi = req.body.DiaChi;
        storageDB.update(entity).then(row =>{
            res.json(200);
        }).catch(err =>{
            console.log(err);
        });
    }).catch(err =>{
        console.log(err);  
    });
});

module.exports = router;