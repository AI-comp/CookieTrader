// Generated by CoffeeScript 1.6.2
(function() {
  var app, controller, express, port;

  express = require('express');

  controller = require('./controller');

  app = express();

  app.configure(function() {
    app.use(express.bodyParser());
    app.use(express.methodOverride());
    app.use(express.cookieParser());
    return app.use(express.session({
      secret: 'secret'
    }));
  });

  controller.start(app);

  port = process.env.PORT || 5000;

  app.listen(port, function() {
    return console.log("Listening on " + port + "\nPress CTRL-C to stop server.");
  });

}).call(this);
