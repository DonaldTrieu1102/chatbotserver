module.exports = function (app) {
    //router admin
    app.use("/admin", require('./admin/index'));
    app.use('/login', require('./login.router'));

    require('../controllers/webhook')(app);

}


