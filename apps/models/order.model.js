var db = require('../../utils/database');

module.exports = {
    all:()  => {
        return db.excute('select * from hoadon');
    },
    add: (entity) => {
        return db.add('hoadon', entity);
    },
    delete: (id) => {
        return db.delete('hoadon', 'MaHoaDon', id);
    },
    findOne: (id) => {
        var sql = `select * from hoadon where MaHoaDon = ${id}`;
        return db.excute(sql);
    }
}