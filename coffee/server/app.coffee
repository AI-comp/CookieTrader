express = require('express')
http = require('http')
io = require('socket.io')
controller = require('./controller')
http = require('http')

app = express()
app.configure(() ->
  app.use(express.bodyParser())
  app.use(express.methodOverride())
  app.use(express.cookieParser())
  app.use(express.session({ secret: 'secret' }))
  app.use(express.static(__dirname + '/public'))
)

server = http.createServer(app)
controller.routes(app)
controller.websocket(io.listen(server))

port = process.env.PORT || 5000

server.listen(port, ->
  console.log("Listening on " + port + "\nPress CTRL-C to stop server.")
)

