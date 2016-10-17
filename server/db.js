var mongoose = require('../node_modules/mongoose'),
    Schema = mongoose.Schema;

mongoose.connect('mongodb://localhost:27017/maltajsdb', function () {
    console.log('Mongodb connected');
});
module.exports = mongoose;
