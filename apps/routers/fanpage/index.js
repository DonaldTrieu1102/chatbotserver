const express = require('express');
const router = express.Router();
const config = require('config');
const request = require('request');
var socket = require('../../socket/socket.index');

const PAGE_ACCESS_TOKEN = config.get('facebook.PAGE_ACCESS_TOKEN');

//rqr mongo db
const userModel = require('../../models/fanpage.model/user.model');
const converModel = require('../../models/fanpage.model/conversation.model');
const messageModel = require('../../models/fanpage.model/message.model');

router.use(require('../../middlewares/fanpage.mdw'));
router.use(require("../../middlewares/product.mdw"));
// Accepts POST requests at /webhook endpoint
router.post('/webhook', (req, res) => {

    let body = req.body;
    console.log(body);

    if (body.object === 'page') {
        body.entry.forEach(function (entry) {

            // Get the webhook event. entry.messaging is an array, but 
            // will only ever contain one event, so we get index 0
            for (let messaging of entry.messaging) {
                let sender_psid = messaging.sender.id;
                console.log('Sender PSID: ' + sender_psid);

                // Check if the event is a message or postback and
                // pass the event to the appropriate handler function
                if (messaging.message) {
                    //send message to client
                    socket.saveMessage(messaging);
                    socket.sendMessageToClient(sender_psid, messaging);
                    handleMessage(sender_psid, messaging.message);
                } else if (messaging.postback) {
                    handlePostback(sender_psid, messaging.postback);
                }
            }
        });
        res.sendStatus(200);

    } else {
        // Return a '404 Not Found' if event is not from a page subscription
        res.sendStatus(404);
    }
});


// Accepts GET requests at the /webhook endpoint
router.get('/webhook', (req, res) => {

    /** UPDATE YOUR VERIFY TOKEN **/
    const VERIFY_TOKEN = "donaldtrieu1102";

    // Parse params from the webhook verification request
    let mode = req.query['hub.mode'];
    let token = req.query['hub.verify_token'];
    let challenge = req.query['hub.challenge'];

    // Check if a token and mode were sent
    if (mode && token) {

        // Check the mode and token sent are correct
        if (mode === 'subscribe' && token === VERIFY_TOKEN) {

            // Respond with 200 OK and challenge token from the request
            console.log('WEBHOOK_VERIFIED');
            res.status(200).send(challenge);

        } else {
            // Responds with '403 Forbidden' if verify tokens do not match
            res.sendStatus(403);
        }
    }
});

// Handles messages events
function handleMessage(sender_psid, received_message) {
    let response;

    // Check if the message contains text
    if (received_message.text) {
        // Create the payload for a basic text message
        response = {
            "text": `You sent the message: "${received_message.text}". Now send me an image!`
        }
    }

    // Sends the response message
    callSendAPI(sender_psid, response);
}



// Handles messaging_postbacks events
function handlePostback(sender_psid, received_postback) {

}
// Gửi thông tin tới REST API để trả lời
function callSendAPI(senderId, message) {
    // Send the HTTP request to the Messenger Platform
    // Construct the message body
    let request_body = {
        "recipient": {
            "id": senderId
        },
        "message": message
    }

    request({
        "uri": "https://graph.facebook.com/v2.6/me/messages",
        "qs": { "access_token": PAGE_ACCESS_TOKEN },
        "method": "POST",
        "json": request_body
    }, (err, res, body) => {
        if (!err) {
            console.log('message sent!')
        } else {
            console.error("Unable to send message:" + err);
        }
    });
}

router.post('/message/:id', (req, res) => {
    var sender_id = req.params.id;
    console.log(sender_id);
    var msg = req.body.text;
    socket.saveMessageMine(msg, sender_id);
})

router.get('/user/:id', (req, res) => {
    var id = req.params.id;
    Promise.all([userModel.all(),
        messageModel.findByUserId(id)])
    .then(values => {
        var user = values[0].filter(x => x._id === id);

        for (const item of values[1]) {
            if (+item.recipient.id != -1) {
                item.active = true;
            }
        }
        res.render('fanpage/index', { layout: '_layouts/fanpage', users: values[0], msg: values[1], user: user[0] });
    }).catch(err => {
        console.log('Failed to get user info, Err: ' + err);
    })
})

router.get('/', (req, res) => {
    userModel.all().then(users => {

        //load the first person msg
        var firstPerson = users[0];
        users[0].isActive = true;

        messageModel.findByUserId(firstPerson._id).then(msg => {
            for (const item of msg) {
                if (+item.recipient.id != -1) {
                    item.active = true;
                }
            }
            res.render('fanpage/index', { layout: '_layouts/fanpage', users: users, msg: msg, user: firstPerson });
        }).catch(err => {
            console.log('failed to load message');
            res.render('fanpage/index', { layout: '_layouts/fanpage', users: values });
        })
    })
        .catch(err => {
            console.log('Failed to load all messenger, Err: ' + err);
        })
})



module.exports = router;