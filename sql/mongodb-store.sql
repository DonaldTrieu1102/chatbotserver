/*
 Navicat Premium Data Transfer

 Source Server         : mongo-sample
 Source Server Type    : MongoDB
 Source Server Version : 40009
 Source Host           : localhost:27017
 Source Schema         : store

 Target Server Type    : MongoDB
 Target Server Version : 40009
 File Encoding         : 65001

 Date: 09/06/2019 11:38:59
*/


// ----------------------------
// Collection structure for conversations
// ----------------------------
db.getCollection("conversations").drop();
db.createCollection("conversations");

// ----------------------------
// Documents of conversations
// ----------------------------
db.getCollection("conversations").insert([ {
    _id: ObjectId("5cfbcf83f2adaef109a42697"),
    "user_id": "2815982425096206",
    "last_modified": "09/06/2019 11:37"
} ]);
db.getCollection("conversations").insert([ {
    _id: ObjectId("5cfbf3cdf2adaef109a51c8f"),
    "user_id": {
        text: "hello"
    },
    "last_modified": "09/06/2019 12:44"
} ]);
db.getCollection("conversations").insert([ {
    _id: ObjectId("5cfbf40df2adaef109a51cd2"),
    "user_id": {
        text: "awawd"
    },
    "last_modified": "09/06/2019 12:44"
} ]);
db.getCollection("conversations").insert([ {
    _id: ObjectId("5cfbf41ef2adaef109a51cdf"),
    "user_id": {
        text: ""
    },
    "last_modified": "09/06/2019 12:46"
} ]);
db.getCollection("conversations").insert([ {
    _id: ObjectId("5cfbf462f2adaef109a51cea"),
    "user_id": {
        text: "QSqs"
    },
    "last_modified": "09/06/2019 12:46"
} ]);
db.getCollection("conversations").insert([ {
    _id: ObjectId("5cfbf53cf2adaef109a51d08"),
    "user_id": {
        text: "awdawdadw"
    },
    "last_modified": "09/06/2019 12:49"
} ]);
db.getCollection("conversations").insert([ {
    _id: ObjectId("5cfbf5c1f2adaef109a51d83"),
    "user_id": {
        text: "awdawdawd"
    },
    "last_modified": "09/06/2019 12:52"
} ]);
db.getCollection("conversations").insert([ {
    _id: ObjectId("5cfbf613f2adaef109a51d99"),
    "user_id": null,
    "last_modified": "09/06/2019 10:19"
} ]);
db.getCollection("conversations").insert([ {
    _id: ObjectId("5cfbf625f2adaef109a51da2"),
    "user_id": "awdawd",
    "last_modified": "09/06/2019 12:53"
} ]);
db.getCollection("conversations").insert([ {
    _id: ObjectId("5cfbf646f2adaef109a51dac"),
    "user_id": "adawdawdawd",
    "last_modified": "09/06/2019 12:54"
} ]);
db.getCollection("conversations").insert([ {
    _id: ObjectId("5cfc7b72f2adaef109a52d68"),
    "user_id": "28159824250961206",
    "last_modified": "09/06/2019 10:22"
} ]);
db.getCollection("conversations").insert([ {
    _id: ObjectId("5cfc8d18f2adaef109a54875"),
    "user_id": "28159812425096206",
    "last_modified": "09/06/2019 11:37"
} ]);

// ----------------------------
// Collection structure for messages
// ----------------------------
db.getCollection("messages").drop();
db.createCollection("messages");

// ----------------------------
// Documents of messages
// ----------------------------
db.getCollection("messages").insert([ {
    _id: ObjectId("5cfc7b3cef6b1d33e8a31b63"),
    sender: {
        id: "2815982425096206"
    },
    timestamp: "09/06/2019 10:21",
    message: {
        text: "TEST_MESSAGE"
    },
    recipient: {
        id: "425234208073127"
    },
    "conversation_id": ObjectId("5cfbcf83f2adaef109a42697")
} ]);
db.getCollection("messages").insert([ {
    _id: ObjectId("5cfc7b43ef6b1d33e8a31b64"),
    sender: {
        id: "2815982425096206"
    },
    recipient: {
        id: NumberInt("-1")
    },
    timestamp: "09/06/2019 10:21",
    "conversation_id": ObjectId("5cfbcf83f2adaef109a42697"),
    message: {
        text: "hello"
    }
} ]);
db.getCollection("messages").insert([ {
    _id: ObjectId("5cfc7b50ef6b1d33e8a31b65"),
    sender: {
        id: "2815982425096206"
    },
    timestamp: "09/06/2019 10:21",
    message: {
        text: "TEST_MESSAGE"
    },
    recipient: {
        id: "425234208073127"
    },
    "conversation_id": ObjectId("5cfbcf83f2adaef109a42697")
} ]);
db.getCollection("messages").insert([ {
    _id: ObjectId("5cfc7b54ef6b1d33e8a31b66"),
    sender: {
        id: "2815982425096206"
    },
    recipient: {
        id: NumberInt("-1")
    },
    timestamp: "09/06/2019 10:21",
    "conversation_id": ObjectId("5cfbcf83f2adaef109a42697"),
    message: {
        text: "hello"
    }
} ]);
db.getCollection("messages").insert([ {
    _id: ObjectId("5cfc7b73ef6b1d33e8a31b67"),
    sender: {
        id: "28159824250961206"
    },
    timestamp: "09/06/2019 10:22",
    message: {
        text: "TEST_MESSAGE"
    },
    recipient: {
        id: "425234208073127"
    },
    "conversation_id": ObjectId("5cfc7b72f2adaef109a52d68")
} ]);
db.getCollection("messages").insert([ {
    _id: ObjectId("5cfc7b81ef6b1d33e8a31b69"),
    sender: {
        id: "2815982425096206"
    },
    timestamp: "09/06/2019 10:22",
    message: {
        text: "TEST_MESSAGE"
    },
    recipient: {
        id: "425234208073127"
    },
    "conversation_id": ObjectId("5cfbcf83f2adaef109a42697")
} ]);
db.getCollection("messages").insert([ {
    _id: ObjectId("5cfc7c29ef6b1d33e8a31b6a"),
    sender: {
        id: "2815982425096206"
    },
    timestamp: "09/06/2019 10:25",
    message: {
        text: "TEST_MESSAGE"
    },
    recipient: {
        id: "425234208073127"
    },
    "conversation_id": ObjectId("5cfbcf83f2adaef109a42697")
} ]);
db.getCollection("messages").insert([ {
    _id: ObjectId("5cfc7c2eef6b1d33e8a31b6b"),
    sender: {
        id: "2815982425096206"
    },
    recipient: {
        id: NumberInt("-1")
    },
    timestamp: "09/06/2019 10:25",
    "conversation_id": ObjectId("5cfbcf83f2adaef109a42697"),
    message: {
        text: "hello"
    }
} ]);
db.getCollection("messages").insert([ {
    _id: ObjectId("5cfc8d0dd3cb0a1b401b1403"),
    sender: {
        id: "2815982425096206"
    },
    timestamp: "09/06/2019 11:37",
    message: {
        text: "TEST_MESSAGE"
    },
    recipient: {
        id: "425234208073127"
    },
    "conversation_id": ObjectId("5cfbcf83f2adaef109a42697")
} ]);
db.getCollection("messages").insert([ {
    _id: ObjectId("5cfc8d19d3cb0a1b401b1404"),
    sender: {
        id: "28159812425096206"
    },
    timestamp: "09/06/2019 11:37",
    message: {
        text: "TEST_MESSAGE"
    },
    recipient: {
        id: "425234208073127"
    },
    "conversation_id": ObjectId("5cfc8d18f2adaef109a54875")
} ]);
db.getCollection("messages").insert([ {
    _id: ObjectId("5cfc8d22d3cb0a1b401b1406"),
    sender: {
        id: "2815982425096206"
    },
    timestamp: "09/06/2019 11:37",
    message: {
        text: "TEST_MESSAGE"
    },
    recipient: {
        id: "425234208073127"
    },
    "conversation_id": ObjectId("5cfbcf83f2adaef109a42697")
} ]);

// ----------------------------
// Collection structure for users
// ----------------------------
db.getCollection("users").drop();
db.createCollection("users");
db.getCollection("users").createIndex({
    1: ""
}, {
    name: "_id"
});

// ----------------------------
// Documents of users
// ----------------------------
db.getCollection("users").insert([ {
    _id: "2815982425096206",
    "first_name": "Cuộc Đời",
    "last_name": "Kệ",
    "profile_pic": "https://platform-lookaside.fbsbx.com/platform/profilepic/?psid=2815982425096206&width=1024&ext=1562582025&hash=AeQsipZnPwY-T45S",
    "created_at": "08/06/2019 05:33"
} ]);
