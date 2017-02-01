var mongoose = require('../../node_modules/mongoose'),
    Schema = mongoose.Schema;
/*
Subscribers Schema
 */
var subscriberSchema = new Schema({
    firstName: { type: String },
    lastName: {type: String },
    company: {type: String },
    email: {type: String, required: true}
});
var subscriber = mongoose.model('subscriber', subscriberSchema);

module.exports = {
    Subscribers: subscriber
};
