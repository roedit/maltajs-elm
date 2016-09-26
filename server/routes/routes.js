module.exports= function(app) {
    var model     = require('../models/schema');
    var nodemailer = require('../../devtools/node_modules/nodemailer');
    var sgTransport = require('../../devtools/node_modules/nodemailer-sendgrid-transport');
    /**
     * Get subscribers list
     * http://localhost:3000/api/subscribers
     */
    app.get('/api/joined', function(req, res) {
        var query = model.Subscribers.find();

        query.exec(function(err,subscribers){
            console.log(subscribers);
            res.send(subscribers);
        });
    });

    /**
     * Add subscriber
     * http://localhost:3000/api/add-subscriber
     */
    app.post('/api/add-subscriber', function(req, res) {
        console.log(req.body);
        var subscriber = new model.Subscribers();

        subscriber.subscriberFirstName = req.body.subscriberFirstName;
        subscriber.subscriberLastName = req.body.subscriberLastName;
        subscriber.subscriberCompany = req.body.subscriberCompany;
        subscriber.subscriberEmail = req.body.subscriberEmail;
        subscriber.save(function(err, subscriber) {
            if (err) {
                // if an error occurs, show it in console
                console.log(err);
                return err;
            }

            res.send(subscriber);
        });
    });

    app.post('/api/contact', function(req, res) {
        console.log(req.body);

        var options = {
          auth: {}
        };

        var client = nodemailer.createTransport(sgTransport(options));

        var email = {
          from: req.body.email,
          to: 'boggdan.dumitriu@gmail.com, tzuuc@yahoo.com, contact@maltajs.com',
          subject: 'MaltaJs Conference 2015',
          text: '',
          html: 'This a message from: '+ req.body.name + '<br>' +
                '<p>Phone no: ' + req.body.phone + '</p></br>' +
                '<p>Message: ' + req.body.message + '</p>' 
        };

        client.sendMail(email, function(err, info){
            if (err ){
              console.log(error);
            }
            else {
              console.log('Message sent: ' + info.message);
              res.send('Email sent succesfully');
            }
        });
    });
};