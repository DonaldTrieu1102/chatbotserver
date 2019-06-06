module.exports = function (app) {

    // const { FacebookAdapter } = require('botbuilder-adapter-facebook');
    // const { Botkit } = require('botkit');
    // const config = require('config');

    // const adapter = new FacebookAdapter({
    //     verify_token: process.env.FACEBOOK_VERIFY_TOKEN || config.get('facebook.VERIFY_TOKEN'),
    //     app_secret: process.env.FACEBOOK_APP_SECRET || config.get('facebook.APP_SECRET'),
    //     access_token: process.env.FACEBOOK_ACCESS_TOKEN || config.get('facebook.PAGE_ACCESS_TOKEN')
    // })


    // var mongoUri = process.env.MONGODB_URI || 'mongodb://localhost/mongo-sample'
    // var db = require('../common/mongo')({ mongoUri: mongoUri })

    // const controller = new Botkit({
    //     adapter: adapter,
    //     webserver: app,
    //     storage: db
    // });

    // controller.on('message', async (bot, message) => {
    //     console.log(message);
    //     await bot.reply(message, 'I heard a message');
    // });

    // controller.hears('hello', 'message', async (bot, message) => {
    //     // do something!
    //     console.log(message);
    //     await bot.reply(message, 'Hello human')
    // });

    // Đây là đoạn code để tạo Webhook
    app.get('/webhook', function (req, res) {
        if (req.query['hub.verify_token'] === 'teamwork') {
            res.send(req.query['hub.challenge']);
        }
        else res.send('Error, wrong validation token');
    });

    app.post('/webhook', (req, res) => {
        var entries = req.body.entry;
        for (var entry of entries) {
            var message = entry.message;
            var senderId = entry.sender.id;
            if (message.text) {
                var text = message.text;
                console.log(text); // In tin nhắn người dùng
                sendMessage(senderId, "Tui là bot đây: " + text);
            }
        }

    });
    // Gửi thông tin tới REST API để trả lời
    function sendMessage(senderId, message) {
        request({
            uri: "https://graph.facebook.com/v2.6/me/messages",
            qs: {
                access_token: "EAAgNFI2d5ZCMBADVTcpmSv2IHe75t9Q0b0YnY988XKjCZB4qZCwKascCDFokntijnKvGvfHjP8X1G00zZABveinZCAyxOZBhwAQpfByzPaMgsftrJrJPUd5uF8ZA7SsZCHY25uGXZB0BKGYsbQuCrpMyGuJZAthpnqwqIqEWeTgSdKAP0REUmh1TQn",
            },
            method: 'POST',
            json: {
                recipient: {
                    id: senderId
                },
                message: {
                    text: message
                }
            }
        });
    }
}