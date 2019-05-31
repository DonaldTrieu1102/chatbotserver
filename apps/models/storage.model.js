var db = require('../../utils/database');

module.exports = {
    findAll : ()=>{
        return db.findAll('khohang');
    },
    delete : (id) =>{
        return db.delete('khohang', 'MaKhoHang', id)
    },
    add : (entity) =>{
        return db.add('khohang', entity);
    },
    findById: (id) =>{
        return db.findById('khohang', 'MaKhoHang', id);
    },
    update: (entity) => {
        return db.update('khohang', 'MaKhoHang', entity);
    }
}