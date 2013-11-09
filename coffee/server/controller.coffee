Room = require('./room')
Player = require('./player')

rooms = {}

routes = (app) ->
  app.get '/', (req, res) ->
    res.send('Please access "/room/:id". :id indicates the room id. You can choose any string as a room id (e.g. /room/1).');
  app.get '/room/:id', (req, res) ->
    res.render 'index.ejs', {
      locals: {
        message: "Hello, world!",
        roomId: req.params.id
      }
    }

websocket = (io) ->
  io.sockets.on 'connection', (socket) ->

    socket.on 'enter', (obj) ->
      roomId = obj.roomId
      if !(roomId in rooms)
        rooms[roomId] = new Room(roomId)
      rooms[roomId].enterAudience()
      socket.set('roomId', roomId);
      socket.join(roomId)

    socket.on 'participate', (obj) ->
      socket.get 'roomId', (err, roomId) ->
        room = rooms[roomId]
        player = room.participatePlayer(obj.name)
        socket.to(roomId).emit('participate', { player: player })
        if room.isReady
          socket.to(roomId).emit('start')
          room.start()

    socket.on 'getInfo', (obj) ->
      socket.get 'roomId', (err, roomId) ->
        room = rooms[roomId]
        player = obj.player
        room.updatePlayer(player)
        socket.to(roomId).emit 'getInfo', {
          allPlayers: room.allPlayers(),
          bakeries: room.globalBakeries(),
          milliSeconds: room.getTime()
        }

    socket.on 'buy', (obj) ->
      socket.get 'roomId', (err, roomId) ->
        room = rooms[roomId]
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
        socket.to(roomId).emit('buy', res)

    socket.on 'sell', (obj) ->
      socket.get 'roomId', (err, roomId) ->
        room = rooms[roomId]
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
        socket.to(roomId).emit('sell', res)

exports.routes = routes
exports.websocket = websocket
