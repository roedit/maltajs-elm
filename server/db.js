var mongoose = require('../devtools/node_modules/mongoose'),
    Schema = mongoose.Schema;

mongoose.connect('mongodb://localhost:23000/maltajsdb', function () {
    console.log('Mongodb connected')
});
module.exports = mongoose;