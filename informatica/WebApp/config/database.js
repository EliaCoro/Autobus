const mysql = require('mysql');

var config = {
    host: '127.0.0.1',
    user: 'root',
    password: '',
    database: 'autobus',
    port: 3306,
};

const conn = new mysql.createConnection(config);
module.exports = config;