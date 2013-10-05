routes = (app) ->
  app.get('/', (req, res) ->
    console.log("hello, world!");
    res.render('index.ejs', {locals:{ message: "Hello, world!" }});
  )

websocket = (io) ->
  io.sockets.on('connection', (socket) ->
    socket.on('message', (message) ->
      socket.send(message)
      socket.broadcast.emit(message)
    )
  )

exports.routes = routes
exports.websocket = websocket
