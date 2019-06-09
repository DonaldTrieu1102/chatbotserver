var db = require('../../common/mongo');

module.exports = {
    add: (entity) => {
        return db.insertOne('users', entity);
    },
    all: () => {
        return db.all('users');
    },
    findOne: (senderId) => {
        var query = {"_id" : senderId};
        return db.findOne("users", query);
    }
} 