var express = require('express');
var router = express.Router();

router.use('/', (req, res) => {
    res.render('fanpage/index', {layout: '_layouts/fanpage'});
})

module.exports = router;