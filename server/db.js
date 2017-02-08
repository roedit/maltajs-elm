var mongoose = require('../node_modules/mongoose'),
    Schema = mongoose.Schema;

var mongoPort = process.env.MONGODB_PORT || 27017
var mongoUrl = process.env.MONGODB_URI || 'mongodb://localhost:' + mongoPort + '/maltajsdb'

// from https://gist.github.com/mongolab-org/9959376
var options = { server: { socketOptions: { keepAlive: 300000, connectTimeoutMS: 30000 } }, 
                replset: { socketOptions: { keepAlive: 300000, connectTimeoutMS : 30000 } } };

mongoose.connection.on('error', console.error.bind(console, 'connection error:'));  
 
mongoose.connection.once('open', function(err) {
  // Wait for the database connection to establish, then start the app.       A
  console.log('connection is actually open!')
});

// Connect db
mongoose.connect(mongoUrl, function (error) {
  console.log('Connecting db at '+ mongoUrl)
  if (error) {
    throw error
  }
  console.log('Mongodb connected to '+ mongoUrl)
});

module.exports = mongoose;
