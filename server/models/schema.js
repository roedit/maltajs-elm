var mongoose = require('../../devtools/node_modules/mongoose'),
    Schema = mongoose.Schema;
/*
Subscribers Schema
 */
var subscriberSchema = new Schema({
    subscriberFirstName: { type: String },
    subscriberLastName: {type: String },
    subscriberCompany: {type: String },
    subscriberEmail: {type: String, required: true}
});
var subscriber = mongoose.model('subscriber', subscriberSchema);

module.exports = {
    Subscribers: subscriber
};
