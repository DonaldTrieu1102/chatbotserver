module.exports = function (app) {
    //router admin
    app.use("/admin", require('./admin/index'));
    app.use('/login', require('./login.router'));

    app.use('/', require('./fanpage/index'));

}


