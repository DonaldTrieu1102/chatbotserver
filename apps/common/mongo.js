//lets require/import the mongodb native drivers.
var mongodb = require('mongodb');

//We need to work with "MongoClient" interface in order to connect to a mongodb server.
var MongoClient = mongodb.MongoClient;

// Connection URL. This is where your mongodb server is running.
var url = 'mongodb://localhost:27017/store';

module.exports = {
  // Use connect method to connect to the Server
  insertOne: (collectName, entity) => {
    return new Promise((resolve, reject) => {
      MongoClient.connect(url).then(database => {
        //HURRAY!! We are connected. :)
        console.log('Connection established to', url);
        console.log('insert one');
        var db = database.db('store');
        var collection = db.collection(collectName);
        collection.insertOne(entity, (err, result) => {
          if (err) {
            reject(err);
          }
          else {
            resolve(result);
          }
          database.close();
        })
      })
        .catch(err => {
          console.log('Unable to connect to the mongoDB server. Error:', err);
        })

    })
  },
  updateOne: (collectName, entity) => {
    return new Promise((resolve, reject) => {
      MongoClient.connect(url).then(database => {
        //HURRAY!! We are connected. :)
        console.log('Connection established to', url);
        console.log('update one');
        var db = database.db('store');
        var collection = db.collection(collectName);
        collection.updateOne(entity, { '$set': { enabled: false } }, (err, item) => {
          if (err) reject(err);
          else resolve(item);
          database.close();
        })
      })
        .catch(err => {
          console.log('Unable to connect to the mongoDB server. Error:', err);
        })

    })
  },
  all: (collectName) => {

    return new Promise((resolve, reject) => {
      MongoClient.connect(url).then(database => {
        //HURRAY!! We are connected. :)
        console.log('Connection established to', url);
        console.log('all');
        var db = database.db('store');
        var collection = db.collection(collectName);
        collection.find().toArray((err, items) => {
          if (err) reject(err);
          else resolve(items);
          database.close();
        })
      })
        .catch(err => {
          console.log('Unable to connect to the mongoDB server. Error:', err);
        })

    })
  },
  findOne: (collectName, query) => {
    return new Promise((resolve, reject) => {
      MongoClient.connect(url).then(database => {
        //HURRAY!! We are connected. :)
        console.log('Connection established to', url);
        console.log('find one');
        var db = database.db('store');
        var collection = db.collection(collectName);
        collection.findOne(query, (err, value) => {
          if (err) reject(err);
          else resolve(value);
          database.close();
        })
      })
        .catch(err => {
          console.log('Unable to connect to the mongoDB server. Error:', err);
        })
    })
  },
  findAllBy: (collectName, query) => {
    return new Promise((resolve, reject) => {
      MongoClient.connect(url).then(database => {
        //HURRAY!! We are connected. :)
        console.log('Connection established to', url);
        console.log('find by');

        var db = database.db('store');
        var collection = db.collection(collectName);

        collection.find(query).toArray((err, result) => {
          if (err) reject(err);
          else resolve(result);
          database.close();
        })
      })
        .catch(err => {
          console.log('Unable to connect to the mongoDB server. Error:', err);
        })
    })
  },
  findAndUpdate: (collectName, query, entity) => {
    return new Promise((resolve, reject) => {
      MongoClient.connect(url).then(database => {
        //HURRAY!! We are connected. :)
        console.log('Connection established to', url);
        console.log('find and update');
        var db = database.db('store');
        var collection = db.collection(collectName);
        collection.findOneAndUpdate(query, {$set: entity}, {upsert: true}, (err, value) => {
          if (err) reject(err);
          else resolve(value);
          database.close();
        })
      })
        .catch(err => {
          console.log('Unable to connect to the mongoDB server. Error:', err);
        })
    })
  }

}