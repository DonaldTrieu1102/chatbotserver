var db = require('../../common/mongo');

module.exports = {
    add: (entity) => {
        return db.insertOne('conversations', entity);
    },
    findAndUpdate: (entity) => {
        var query = {"user_id" : entity.user_id};
        return db.findAndUpdate("conversations", query, entity);
    }
}