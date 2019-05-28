var db = require('../../utils/database');
module.exports = {
    all: () => {
        return db.excute('select * from sanpham JOIN chitietsanpham on sanpham.MaSanPham = chitietsanpham.MaSanPham');
    }
}