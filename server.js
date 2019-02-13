var express = require('express');
var app = express();
var path = require('path');

// viewed at http://localhost:8080
app.use(express.static(__dirname + '/site'));
app.use(express.static(__dirname + '/node_modules/web3/dist'));

app.get('/', function(req, res) {
    res.sendFile(path.join(__dirname + '/site/index.html'));
});

app.get('/puntos', function(req, res) {
    res.sendFile(path.join(__dirname + '/site/puntos.html'));
});

app.get('/firmando', function(req, res) {
    res.sendFile(path.join(__dirname + '/site/firmando.html'));
});

app.listen(8080);

console.log('Site available on port 8080')