start = (app, io) ->
  app.get('/', (req, res) ->
    console.log("hello, world!");
    res.render('index.ejs', {locals:{ message: "Hello, world!" }});
  )

  io.on('connection', (client) ->
    client.on('message', (message) ->
      client.send(message)
      client.broadcast(message)
    )
  )

exports.start = start
