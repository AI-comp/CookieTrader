routes = (app) ->
  app.get('/', (req, res) ->
    res.render('index.ejs', {locals:{ message: "Hello, world!" }});
  )

websocket = (io) ->
  io.sockets.on('connection', (socket) ->
    socket.on('message', (message) ->
      socket.send(message)
      socket.broadcast.emit(message)
    )

    socket.on('buy', (obj) ->
      console.log(obj.bakery)
      res = JSON.stringify(
        bakeryName: obj.bakery
        price: Math.floor(Math.random()*1000)
      )
      socket.emit('buy', res)
    )
  )

exports.routes = routes
exports.websocket = websocket
