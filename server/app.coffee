express = require('express')
controller = require('./controller')

app = express()
app.configure(() -> 
  app.use(express.bodyParser())
  app.use(express.methodOverride())
  app.use(express.cookieParser())
  app.use(express.session({ secret: 'secret' }))
)

controller.start(app)
port = process.env.PORT || 5000
app.listen(port, ->
  console.log("Listening on " + port + "\nPress CTRL-C to stop server.")
)
