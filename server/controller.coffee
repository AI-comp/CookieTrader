start = (app) ->
  app.get('/', (req, res) ->
    console.log("hello, world!");
    res.render('index.ejs', {locals:{ message: "Hello, world!" }});
  );

exports.start = start
