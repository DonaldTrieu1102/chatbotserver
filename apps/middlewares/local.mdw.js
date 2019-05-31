var categoriesDB = require('../models/categories.model');

module.exports = (req,res,next) => {
    categoriesDB.findAll().then(rows =>{
        res.locals.lcCate = rows;
        next();
    }).catch(err =>{
        console.log(err);
    })
}