var db = require('../../utils/database');
module.exports = {
    all: () => {
        return db.loadAll('magiamgia');
    },
    delete: (id) => {
        return db.delete('magiamgia', 'magiamgia', id);
    },
    add: (entity) => {
        return db.add('magiamgia', entity);
    },
    findOne: id => {
        return db.findOne('magiamgia', 'magiamgia', id);
    },
    update: entity => {
        return new Promise((resolve, reject) => {
            var connection = db.createConnection();
            connection.connect();
            var sql = `update magiamgia set ? where magiamgia = ?`;
            connection.query(sql, [entity, entity.MaGiamGia], (error, value) => {
                if (error)
                    reject(error);
                else {
                    resolve(value.changedRows);
                }
                connection.end();
            });
        });
    }
}