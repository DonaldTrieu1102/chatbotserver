var db = require('../../utils/database');
function addProductDetail(entity) {
    return db.add('chitietsanpham', entity);
}
function deleteProductDetail(id) {
    return db.delete('chitietsanpham', 'MaSanPham', id);
}
module.exports = {
    addProductDetail: addProductDetail,
    deleteProductDetail: deleteProductDetail,
    findOne: (id) => {
        return db.findOne('chitietsanpham', 'MaSanPham', id);
    },
    findById: (id) =>{
        return db.findById('chitietsanpham', 'MaSanPham',id);
    },
    update: (entity) =>{
        return db.update('chitietsanpham', 'MaSanPham', entity);
    },
}