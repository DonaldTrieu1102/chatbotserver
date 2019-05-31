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
    }
}