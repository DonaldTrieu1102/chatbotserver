var mysql = require('mysql');

var createConnection = () => {
    return mysql.createConnection({
        host: 'localhost',
        user: 'root',
        password: '123123',
        database: 'manage-store'
    });
}


module.exports = {
    createConnection: createConnection,

    loadAll: tableName => {
        return new Promise((resolve, reject) => {
            var sql = `select * from ${tableName}`
            var conn = createConnection();
            conn.connect();
            conn.query(sql, (error, result) => {
                if (error) reject(error);
                else resolve(result);
            })

            conn.end();
        })
    },
    excute: sql => {
        return new Promise((resolve, reject) => {
            var conn = createConnection();
            conn.connect();
            conn.query(sql, (error, result) => {
                if (error) reject(error);
                else resolve(result);
            })
            conn.end();
        })
    },

    add: (tableName, entity) => {
        return new Promise((resolve, reject) => {
            var sql = `insert into ${tableName} set ?`;
            var connection = createConnection();
            connection.connect();
            connection.query(sql, entity, (error, value) => {
                if (error)
                    reject(error);
                else {
                    resolve(value.insertId);
                }
                connection.end();
            });
        });
    },

    update: (tableName, idField, entity) => {
        return new Promise((resolve, reject) => {
            var id = entity[idField];
            delete entity[idField];

            var sql = `update ${tableName} set ? where ${idField} = ?`;
            var connection = createConnection();
            connection.connect();
            connection.query(sql, [entity, id], (error, value) => {
                if (error)
                    reject(error);
                else {
                    resolve(value.changedRows);
                }
                connection.end();
            });
        });
    },

    delete: (tableName, idField, id) => {
        return new Promise((resolve, reject) => {
            var sql = `delete from ${tableName} where ${idField} = ?`;
            var connection = createConnection();
            connection.connect();
            connection.query(sql, id, (error, value) => {
                if (error)
                    reject(error);
                else {
                    resolve(value.affectedRows);
                }
                connection.end();
            });
        });
    },
    findOne: (tableName, field, value) => {
        return new Promise((resolve, reject) => {
            var sql = `select * from ${tableName} where ${field} = ?`;
            var connection = createConnection();
            connection.connect();
            connection.query(sql, value, (error, values) => {
                if (error)
                    reject(error);
                else {
                    resolve(values);
                }
                connection.end();
            });
        });
    }
};