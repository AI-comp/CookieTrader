Game = require('./model/game').Game
game = new Game

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

    socket.on('buy', (obj) ->
      bakery = obj.bakery
      totalCookie = obj.totalCookie
      price = game.users['hoge'].buy(bakery, game.store, totalCookie)
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
