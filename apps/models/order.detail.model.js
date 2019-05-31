var db = require('../../utils/database');

module.exports = {
    all:()  => {
        return db.excute('select * from chitiethoadon ');
    },
    add: (entity) => {
        return db.add('chitiethoadon', entity);
    },
    findAllByOrderId: id => {
        var sql = `select h.*, s.ten as Ten, s.gia as Gia from chitiethoadon h join  sanpham s
         on h.masanpham = s.masanpham  where mahoadon = ${id}`;
         
        return db.excute(sql);
    }
}