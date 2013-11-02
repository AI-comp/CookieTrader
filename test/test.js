// Generated by CoffeeScript 1.6.3
(function() {
  var Spooky, initialize;

  require('../app');

  Spooky = require('spooky');

  initialize = function(done) {
    var spooky;
    spooky = new Spooky({
      child: {
        transport: 'http'
      },
      casper: {
        logLevel: 'debug',
        verbose: true
      }
    }, function(err) {
      var e;
      if (err) {
        e = new Error('Failed to initialize SpookyJS');
        e.details = err;
        throw e;
      }
      spooky.on('error', function(e, stack) {
        console.error(e);
        if (stack) {
          return console.log(stack);
        }
      });
      spooky.on('console', function(line) {
        console.log(line);
        if (line.match(/FAIL/)) {
          return spooky.fails.push(line);
        }
      });
      spooky.on('log', function(log) {
        if (log.space === 'remote') {
          return console.log(log.message.replace(/\- .*/, ''));
        }
      });
      spooky.debug = true;
      spooky.setUpAndRun = function(done) {
        spooky.fails = [];
        spooky.once('run.complete', function() {
          return done(spooky.fails.length === 0 ? null : new Error(spooky.fails));
        });
        return spooky.run(function() {
          return this.test.done();
        });
      };
      return done();
    });
    return spooky;
  };

  describe('Frontend tests', function() {
    var spooky;
    spooky = null;
    before(function(done) {
      return spooky = initialize(done);
    });
    after(function() {
      return spooky.destroy();
    });
    return it('Open top page', function(done) {
      spooky.start('http://localhost:5000');
      spooky.then(function() {
        return this.test.assertHttpStatus(200, 'successfully received 200 OK');
      });
      return spooky.setUpAndRun(done);
    });
  });

}).call(this);
