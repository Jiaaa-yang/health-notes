const express = require('express');
const bodyParser = require('body-parser');

const PORT_NUMBER = 3000;

const app = express();
app.use(bodyParser.json());

const sqlite3 = require('sqlite3').verbose();
const db = new sqlite3.Database("data/notes.db");

db.run(`CREATE TABLE IF NOT EXISTS notes
        (content TEXT)`, err => {
    if (err) console.log(err);
});

// Fetch all notes from database
app.get('/notes', (req, res) => {
    db.all("SELECT * FROM notes", (err, rows) => {
        res.json(rows);
    })
})

// Add a note with id and text content into database
app.post('/notes', (req, res) => {
    let data = req.body;
    db.run("INSERT INTO notes (content) VALUES (?)", [data.content], err => {
        if (err) console.log(err);
    })
    res.sendStatus(200);
})

app.post('/delete/notes', (req, res) => {
    let data = req.body;
    db.run("DELETE FROM notes WHERE content = ?", [data.content], err => {
        if(err) console.log(err);
    })
    res.sendStatus(200);
})

app.listen(PORT_NUMBER, () => {
    console.log(`Listening on port: ${PORT_NUMBER}`)
});
