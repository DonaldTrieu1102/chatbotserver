var db = require('../../utils/database');

module.exports = {
    findAll : ()=>{
        return db.findAll('khohang');
    }
}