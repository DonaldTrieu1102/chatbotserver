module.exports = function (app) {

    const PAGE_ACCESS_TOKEN = "EAAdISHr7nwcBAJz0GU0SOLsk1wjEmj4lgNYZByU7DwuuwQ6vzi5u7YRZCff8geZAvKvw4QL6m7xFWKiNAW4kOyzwPYNS3MCev9MpiOhTHyDsFKN3kLUBRtbfRT1gR7xnrLbpi0Xl2s4mYf9RH8sEQTZAtyHOviqo58yXPX5YHLc1gnjF66Ed";

    const
        request = require('request');
    // Accepts POST requests at /webhook endpoint
    app.post('/webhook', (req, res) => {

        // Parse the request body from the POST
        let body = req.body;

        // Check the webhook event is from a Page subscription
        if (body.object === 'page') {

            // Iterate over each entry - there may be multiple if batched
            body.entry.forEach(function (entry) {

                // Get the webhook event. entry.messaging is an array, but 
                // will only ever contain one event, so we get index 0
                let webhook_event = entry;

                for (let messaging of entry.messaging) {
                    let sender_psid = messaging.sender.id;
                    console.log('Sender PSID: ' + sender_psid);

                    // Check if the event is a message or postback and
                    // pass the event to the appropriate handler function
                    if (messaging.message) {
                        handleMessage(sender_psid, messaging.message);
                    } else if (messaging.postback) {
                        handlePostback(sender_psid, messaging.postback);
                    }
                }
            });

            // Return a '200 OK' response to all events
            res.status(200).send('EVENT_RECEIVED');

        } else {
            // Return a '404 Not Found' if event is not from a page subscription
            res.sendStatus(404);
        }

    });

    // Accepts GET requests at the /webhook endpoint
    app.get('/webhook', (req, res) => {

        /** UPDATE YOUR VERIFY TOKEN **/
        const VERIFY_TOKEN = "teamwork";

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
}