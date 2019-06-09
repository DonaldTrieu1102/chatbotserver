const moment = require('moment-timezone');
const express = require('express');
const app = express();
const server = require('http').createServer(app);
const config = require('config');
var io = require('socket.io')(server);
const request = require('request');
const PAGE_ACCESS_TOKEN = config.get('facebook.PAGE_ACCESS_TOKEN');

//include database mongodb
const userModel = require('../models/fanpage.model/user.model');
const converModel = require('../models/fanpage.model/conversation.model');
const messageModel = require('../models/fanpage.model/message.model');

//socket realtime
io.on('connection', (socket) => {
    console.log('connect socket success');

    socket.on('send', (data) => {
    })
})

function getUserImage(senderId) {
    return new Promise((resolve, reject) => {
        let uri = "https://graph.facebook.com/" + senderId + "/picture?type=normal";
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
        });
    })
}

function getUserName(senderId) {
    return new Promise((resolve, reject) => {
        let uri = "https://graph.facebook.com/" + senderId;
        request({
            "uri": uri,
            "qs": { "access_token": PAGE_ACCESS_TOKEN },
            "method": "GET",
        }, (err, res, body) => {
            if (!err) {
                console.log(res.body);
                resolve(res.body);
            } else {
                console.error("Unable to send message:" + err);
                reject(err);
            }
        }).end();
    })
}

module.exports = {
    getUserImage,
    getUserName,
    sendMessageToClient: (senderId, messaging) => {
        getUserName(senderId).then(value => {
            var username = value;

            //parse to json
            username = JSON.parse(username);

            //format time
            var date = moment().format('DD/MM/YYYY hh:mm');
            messaging.timestamp = date;

            //check if user exists
            userModel.findOne(senderId).then(value => {
                if (!value) {
                    username['created_at'] = date;
                    username['_id'] = username['id'];
                    delete username['id'];
                    userModel.add(username).then(value => {
                        console.log('Success to add new user');
                    }).catch(err => {
                        console.log('Failed to add new user');
                    })
                    username.isActive = true;
                }
                io.emit('send', { "messaging": messaging, "username": username });
            })
                .catch(err => {
                    console.log('Failed to query database mongo, Err: ' + err);
                })
        })
    },
    saveMessage: (messaging) => {
        //check conversation exist
        var conversation = {};
        conversation.user_id = messaging.sender.id;
        conversation.last_modified = moment().format('DD/MM/YYYY hh:mm');
        converModel.findAndUpdate(conversation).then(value => {

            var conversationId;
            if (!value.value) conversationId = value.lastErrorObject.upserted;
            else conversationId = value.value._id;

            messaging.conversation_id = conversationId;
            messageModel.add(messaging).then(rs => {
                console.log('Save success message have id: ' + rs.insertedId);
            })
                .catch(err => {
                    console.log('Failed to add new message, Err: ' + err);
                })
        }).catch(err => {
            console.log("Failed to add new conversation, Err: " + err);
        })
    },
    saveMessageMine: (message, senderId) => {
        var conversation = {};
        conversation.user_id = senderId;

        var now = moment().format('DD/MM/YYYY hh:mm');
        conversation.last_modified = now;
        converModel.findAndUpdate(conversation).then(value => {
            var conversationId;
            console.log(value);
            if (!value.value) conversationId = value.lastErrorObject.upserted;
            else conversationId = value.value._id;

            var messaging = {
                "sender": { "id": senderId }, "recipient": { "id": -1 }, "timestamp": now, "conversation_id": conversationId
                , "message": { "text": message }
            };
            messageModel.add(messaging).then(rs => {
                console.log('Save success message have id: ' + rs.insertedId);
            })
                .catch(err => {
                    console.log('Failed to add new message, Err: ' + err);
                })
        }).catch(err => {
            console.log("Failed to add new conversation, Err: " + err);
        })
    }
}

server.listen(config.get('socket.port' || 3000));   