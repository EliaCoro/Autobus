var express = require('express');
const mysql = require('mysql');
const session = require('express-session');
const bodyParser = require('body-parser');

var router = express.Router();
var conn = new mysql.createConnection(require("../config/database.js"));

router.get("/tratta", (req, res) => {
    conn.query(`SELECT * FROM tratta`, (error, results, fields) => {
        if (error) {
            return console.error(error.message);
        }
        res.send(JSON.stringify(results))
    });
})

router.get("/fermate", (req, res) => {
    if (req.query.tratta != undefined) {
        conn.query(`SELECT fermata.nome_fermata FROM tratta
INNER JOIN ordine_fermate ON tratta.id = ordine_fermate.id_tratta
INNER JOIN fermata ON ordine_fermate.fermata = fermata.id
WHERE tratta.nome = '${req.query.tratta}'
ORDER BY ordine_fermate.ordine`, (error, results, fields) => {
            if (error) {
                return console.error(error.message);
            }
            res.send(JSON.stringify(results))
        });
    }
})

//ritorna tutte le corse in un giorno specifico
router.get("/giorno", (req, res) => {
    if (req.query.giorno != undefined) {
        conn.query(`SELECT tratta.nome, orario.orario_partenza FROM orario
INNER JOIN tratta ON orario.id_tratta = tratta.id
INNER JOIN giorno ON orario.id_giorno = giorno.id
WHERE giorno.id = '${req.query.giorno}'`, (error, results, fields) => {
            if (error) {
                return console.error(error.message);
            }
            res.send(JSON.stringify(results))
        });
    }
})

//funzione di login
router.post('/login', function (request, response) {
    var email = request.body.email;
    var password = request.body.password;
    if (email && password) {
        if (request.session.loggedin) {
            response.send('Bentornato, ' + request.session.email + '!');
        } else {
            conn.query(`SELECT * FROM account 
        WHERE account.email = '${email}' AND account.password = '${password}'`, function (error, results, fields) {
                if (results.length > 0) {
                    request.session.loggedin = true;
                    request.session.email = email;
                    response.send('Corretto');
                } else {
                    response.send('Errore');
                }
            });
        }
    } else {
        response.send('Errore');
    }
});

//funzione di registrazione
router.post('/register', function (request, response) {
    var nome = request.body.nome;
    var cognome = request.body.cognome;
    var email = request.body.email;
    var password = request.body.password;
    var cellulare = request.body.cellulare;
    if (nome && cognome && email && password && cellulare) {
        conn.query(`SELECT * FROM account 
        WHERE account.email = '${email}'`, function (error, results, fields) {
            if (results.length == 0) {
                conn.query(`INSERT INTO account (nome, cognome, email, password, cellulare) VALUES ('${nome}','${cognome}','${email}','${password}',${cellulare})`);
                response.send('Account creato');
            } else {
                response.send('Esiste già un account con questa mail');
            }
        });
    }
});

module.exports = router;