var db = require('../../utils/database');

module.exports = {
    all: () => {
        return db.loadAll('danhmucsp');
    }
}