const mysql = require('mysql');
const express = require('express');
const path = require('path');
const session = require('express-session');
const bodyParser = require('body-parser');

const app = express()
const port = "8080";

var conn = new mysql.createConnection(require("./config/database.js"));

app.use(session({
    cookieName: 'session',
    secret: 'secret',
    saveUninitialized: true,
    resave: true,
    duration: 30 * 60 * 1000,
    activeDuration: 5 * 60 * 1000,
  }));
  
app.use(bodyParser.urlencoded({
    extended: true
}));
app.use(bodyParser.json());


app.use('/', require("./api/api.js") );

app.get("/", (req, res) => {
    res.sendFile(path.join(__dirname, './views/index.html'))
})

app.listen(port, () => {
    console.log(`App listening at http://localhost:${port}`)
});