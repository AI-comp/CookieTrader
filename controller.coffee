Room = require('./model/room')
Player = require('./public/js/player')
room = new Room

routes = (app) ->
  app.get('/', (req, res) ->
    res.render('index.ejs', {locals:{ message: "Hello, world!" }});
  )

websocket = (io) ->
  io.sockets.on('connection', (socket) ->

    room.enterAudience();

    socket.on('message', (message) ->
      socket.send(message)
      socket.broadcast.emit(message)
    )

    socket.on('participate', (obj) ->
      player = room.participatePlayer(obj.name)
      socket.emit('participate', { player: player })
      if room.isReady
        socket.emit('start', { 'foo': 42 })
    )

    socket.on('buy', (obj) ->
      player = obj.player
      bakery = obj.bakery
      # TODO: room.playerと同期する
      price = Player.buy(player, bakery)
      res =
        if price?
          {
            status: 'ok'
            bakery: bakery
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
