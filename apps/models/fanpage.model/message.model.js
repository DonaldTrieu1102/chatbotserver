var db = require('../../common/mongo');

module.exports = {
    add: (entity) => {
        return db.insertOne('messages', entity);
    },
    findByUserId: (id) => {
        var query = {"sender": {"id" : id}};
        return db.findAllBy('messages', query);
    }
}