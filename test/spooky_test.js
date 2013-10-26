var express = require('express');
var app = express();
 
// setup server
app.get('/', function(req, res){
    res.send('hello spooky');
});
 
module.exports = app;
 
 
// start spooky test
describe('Frontend tests', function() {
    describe('homepage', function() {
        var context = {};
        var hooks = require('./spooky_helper');
        var fails = [];
        var server = app.listen(4000, function() {});
 
        before(hooks.before(context));
 
        afterEach(function() {
            if(!this.ok) this.test.error(new Error(fails));
        });
 
        it('should return a 200 OK status', function(done) {
            var self = this;
            self.ok = true;
 
            // spooky flow start.
            context.spooky.start();
 
            context.spooky.open('http://localhost:4000/');
 
            context.spooky.then(function() {
                // casper API
                this.test.assertHttpStatus(200, 'successfully received 200 OK');
            });
            // spooky flow end.
 
 
            function onComplete() {
                if ( context.spooky.fails.length > 0 ) {
                    fails.push(context.spooky.fails);
                    self.ok = false;
                }
                done();
            }
            context.spooky.on('run.complete', onComplete);
 
            context.spooky.run(function() {
                this.test.done(1);
            });
        });
    });
});
