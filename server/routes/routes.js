module.exports= function(app) {
    var model     = require('../models/schema');
    var nodemailer = require('../../node_modules/nodemailer');
    var sgTransport = require('../../node_modules/nodemailer-sendgrid-transport');
    var AUTH_TOKEN = process.env.AUTH_TOKEN

    /**
     * Get subscribers list
     * http://localhost:3000/api/subscribers
     */
    app.get('/api/joined', function(req, res) {

        if (AUTH_TOKEN === undefined || AUTH_TOKEN === '') {
          res.status(500).send('Token not initialized')
          return
        }

        if (req.query.token !== AUTH_TOKEN) {
          res.status(401).send('Wrong token')
          return
        }

        var query = model.Subscribers.find();

        query.exec(function(err,subscribers){
            res.status('200').send(subscribers);
        });
    });

    /**
     * Add subscriber
     * http://localhost:3000/api/add-subscriber
     */
    app.post('/api/add-subscriber', function(req, res) {

        model.Subscribers.find({ email: req.body.email }, function(err, user) {
          if (user.length > 0) {
            res.status(403).json({ error: 'User already registered' })
          } else {
            var subscriber = new model.Subscribers();

            subscriber.firstName = req.body.name;
            subscriber.lastName = req.body.surname;
            subscriber.company = req.body.company;
            subscriber.email = req.body.email;

            subscriber.save(function(err, subscriber) {
                if (err) {
                    // if an error occurs, show it in console
                    console.log(err);
                    return err;
                }

                res.status(200).json({
                    'subscriber': subscriber.firstName
                });
            });

          }
        })

    });

  // todo: not in use right now
    app.post('/api/contact', function(req, res) {
        console.log(req.body);

        var options = {
          auth: {}
        };

        var client = nodemailer.createTransport(sgTransport(options));

        var email = {
          from: req.body.email,
          to: 'boggdan.dumitriu@gmail.com, tzuuc@yahoo.com, contact@maltajs.com',
          subject: 'MaltaJs Conference 2016',
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
