var express = require("../node_modules/express");
var bodyParser = require("../node_modules/body-parser");
var morgan = require("../node_modules/morgan");
var db = require("./db.js");
var app = express();
var publicFolder = __dirname.replace(/server/,'public/')

// Set the port
app.set("port", process.env.PORT || 3000);
// Set the server working directory
app.use(express.static(publicFolder+'assets/'));
// log every request to the console
app.use(morgan('dev'));
app.use(bodyParser.urlencoded({
    extended: true
}));

app.use(bodyParser.json());

var routes = require('./routes/routes');
// Routes using Express
routes(app);
// App start
app.listen(app.get("port"), function () {
    console.log("Express server listening on port " + app.get("port"));
});

var detector = require('../node_modules/spider-detector');
 
app.use(detector.middleware())

app.get('/', function(req, res) {
  if (req.isSpider()) {
    res.sendFile(publicFolder+'static.html')
  } else {
    res.sendFile(publicFolder+'index.html')
  }
})
