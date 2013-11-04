Room = require('./room')
Player = require('./player')
room = new Room

routes = (app) ->
  app.get('/', (req, res) ->
    res.render('index.ejs', {locals:{ message: "Hello, world!" }})
  )

websocket = (io) ->
  io.sockets.on('connection', (socket) ->

    room.enterAudience()

    socket.on('message', (message) ->
      socket.send(message)
      socket.broadcast.emit(message)
    )

    socket.on('participate', (obj) ->
      player = room.participatePlayer(obj.name)
      socket.emit('participate', { player: player })
      if room.isReady
        socket.emit('start')
    )

    socket.on('getInfo', (obj) ->
      player = obj.player
      room.updatePlayer(player)
      socket.emit('getInfo', { allPlayers: room.allPlayers(), bakeries: room.globalBakeries() })
    )

    socket.on('buy', (obj) ->
      player = obj.player
      bakery = obj.bakery
      # TODO: room.playerと同期する
      price = room.buyBakery(player, bakery)
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

    socket.on('sell', (obj) ->
      player = obj.player
      bakery = obj.bakery
      price = room.sellBakery(player, bakery)
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
            message: 'bakery is not enough'
          }
      socket.emit('sell', res)
    )
  )

exports.routes = routes
exports.websocket = websocket
