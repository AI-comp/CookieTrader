start = (app, io) ->
  app.get('/', (req, res) ->
    console.log("hello, world!");
    res.render('index.ejs', {locals:{ message: "Hello, world!" }});
  )

  io.on('connection', (client) ->
    client.on('message', (message) ->
      d = new Date()
      data = message + d.getHours() + ':' + d.getMinutes() + ':' + d.getSeconds()
      client.emit('message', data)
      client.broadcast.emit('message', data)
      console.log(data)
    )
  )

exports.start = start
