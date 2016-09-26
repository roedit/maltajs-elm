var express            = require("../devtools/node_modules/express");
var bodyParser         = require("../devtools/node_modules/body-parser");
var morgan             = require("../devtools/node_modules/morgan");
var db                 = require("./db.js");

var app                = express();


app.set("port", process.env.PORT || 3000);

app.use(express.static(__dirname + './../public'));
app.use(morgan('dev') ); // Log every request to console
app.use(bodyParser.urlencoded({
    extended: true
}));

app.use(bodyParser.json());

var routes = require('./routes/routes');
routes(app);   //routes shall use Express

app.listen(app.get("port"), function () {
    console.log("Express server listening on port " + app.get("port"));
});
