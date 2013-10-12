exports = this

$ ->
  pretty = (val) ->
    '' + Math.floor(val)

  FPS = 10

  player = new Player(0, 10)
  player.totalCookie = 1000
  player.currentCps = 0

  player.hook 'totalCookie', (v) ->
    $('#my-total-cookie').text(pretty(player.totalCookie))

  player.hook 'currentCps', (v) ->
    $('#my-cps').text(v)

  # WebSocketサーバに接続
  socket = io.connect('http://localhost:5000/')

  socket.on 'connect', ->
    console.log('connect!')

  socket.on 'disconnect', ->
    console.log("disconnect from server")

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

  prevTime = new Date().getTime()
  startTimer = () ->
    curTime = new Date().getTime()

    player.bake((curTime - prevTime) / 1000)

    prevTime = curTime
    setTimeout(startTimer, 1000 / FPS)
  startTimer()
