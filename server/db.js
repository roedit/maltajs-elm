var mongoose = require('../node_modules/mongoose'),
    Schema = mongoose.Schema;

var mongoPort = process.env.MONGODB_PORT || 27017
var mongoUrl = 'mongodb://localhost:' + mongoPort + '/maltajsdb'
// Connect db
mongoose.connect(mongoUrl, function () {
    console.log('Mongodb connected')
});

module.exports = mongoose;
