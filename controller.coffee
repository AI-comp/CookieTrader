Room = require('./model/room')
room = new Room

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
      bakery = obj.bakery
      totalCookie = obj.totalCookie
      price = room.player('hoge').buy(bakery, room.store, totalCookie)
      res =
        if price?
          {
            status: 'ok'
            bakeryName: obj.bakery
            price: price
          }
        else
          {
            status: 'ng'
            message: 'cookie is not enough'
          }
      socket.emit('buy', res)
    )
  )

exports.routes = routes
exports.websocket = websocket
