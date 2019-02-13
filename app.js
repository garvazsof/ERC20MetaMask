var express = require("express");
var bodyParser = require("body-parser");
var config = require("./config");
var routes = require("./routes/routes.js");

var app = express();

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

var cors = require('cors');
app.use(cors({origin: 'http://localhost:8080'}));

app.use("/api", routes);

const PORT = process.env.PORT || config.PORT;

var server = app.listen(PORT, function () {
    console.log("app running on port.", PORT); 
});