
const config = require('config');
const PAGE_ACCESS_TOKEN = config.get('facebook.PAGE_ACCESS_TOKEN');
const request = require('request');

function getInfoMySelf() {
    return new Promise((resolve, reject) => {
        let uri = "https://graph.facebook.com/me";
        request({
            "uri": uri,
            "qs": { "access_token": PAGE_ACCESS_TOKEN },
            "method": "GET",
        }, (err, res, body) => {
            if (!err) {
                resolve(res.body);
            } else {
                console.error("Unable to send message:" + err);
                reject(err);
            }
        }).end();
    })
}

function getUserMyself(id) {
    return new Promise((resolve, reject) => {
        let uri = "https://graph.facebook.com/" + id;
        request({
            "uri": uri,
            "qs": { "access_token": PAGE_ACCESS_TOKEN },
            "method": "GET",
        }, (err, res, body) => {
            if (!err) {
                resolve(res.body);
            } else {
                console.error("Unable to send message:" + err);
                reject(err);
            }
        }).end();
    })
}

module.exports = (req, res, next) => {
    getInfoMySelf().then(value => {
        value = JSON.parse(value);
        res.locals.fp = value;
        next();
    })
        .catch(err => {
            console.log("Failed to get info myself, Err: " + err);
        })
}