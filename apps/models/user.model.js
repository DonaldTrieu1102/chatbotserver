var db = require('../../utils/database');
module.exports = {
    findUserFacebookId: facebookId => {
        return db.findOne('nguoidung', 'facebookId', facebookId);
    }
}