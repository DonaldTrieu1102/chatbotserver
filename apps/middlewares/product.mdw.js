var productDB = require('../models/product.model');

module.exports = (req,res,next) => {
    productDB.all().then(rows =>{
        res.locals.lcProduct = rows;
        next();
    }).catch(err =>{
        console.log(err);
    })
}