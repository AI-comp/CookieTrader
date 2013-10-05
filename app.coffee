express = require('express')
controller = require('./controller')
http = require('http')
ws = require('websocket.io')


app = express()
app.configure(() -> 
  app.use(express.bodyParser())
  app.use(express.methodOverride())
  app.use(express.cookieParser())
  app.use(express.session({ secret: 'secret' }))
  app.use(express.static(__dirname + '/public'))
)

server = http.createServer(app)
socket = ws.attach(server)

socket.on('connection', (client) ->
  client.on('message', (data) ->
    d = new Date()
    message = data + d.getHours() + ':' + d.getMinutes() + ':' + d.getSeconds()
    console.log(message)

    socket.clients.forEach((client) ->
      client.send(message)
    )
  )
)

port = process.env.PORT || 5000
server.listen(port, ->
  console.log("Listening on " + port + "\nPress CTRL-C to stop server.")
)
