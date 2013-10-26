$ ->
  pretty = (val) ->
    '' + Math.floor(val)

  FPS = 10

  player = Player.newPlayer()


  prevTime = null
  startTimer = () ->
    curTime = new Date().getTime()

    Player.earn(player, (curTime - prevTime) / 1000)

    prevTime = curTime
    setTimeout(startTimer, 1000 / FPS)


  started = false
  start = ->
    prevTime = new Date().getTime()
    startTimer()
    started = true


  # WebSocketサーバに接続
  socket = io.connect('http://localhost:5000/')

  socket.on 'connect', ->
    console.log('connect!')

  socket.on 'disconnect', ->
    console.log("disconnect from server")

  socket.on 'start', ->
    start()

  # メッセージ受信イベントを処理
  socket.on 'message', (msg) ->
    console.log('Received : ' + msg)

  socket.on 'buy', (obj) ->
    status = obj.status
    if status == 'ok'
      bakeryName = obj.bakeryName
      price = parseInt(obj.price, 10)
      player.buy(bakeryName, price)

  $(document).keydown (e) ->
    if (e.keyCode == 32 || e.keyCode == 13)
      player.clickCookie()

  $('.bakery-item').click (e) ->
    id = e.target.id
    id.match(/bakery-(.+)/)
    bakeryName = RegExp.$1
    socket.emit('buy', { 'bakery': bakeryName, 'totalCookie': player.totalCookie })

  $('#participate-button').click (e) ->
    socket.emit('participate', { 'name': $('#player-name').val() })

