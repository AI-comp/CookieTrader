$ ->
  pretty = (val) ->
    '' + Math.floor(val)

  FPS = 10

  player = null
  prevTime = null
  started = false


  render = ( ->
    cookieElem = $('#my-total-cookie')
    cpsElem = $('#my-cps')
    ->
      cookieElem.text(~~player.totalCookie)
      cpsElem.text(Player.calcCPS(player.bakeries, player.equips))
  )()

  startTimer = () ->
    curTime = new Date().getTime()
    Player.earn(player, (curTime - prevTime) / 1000)
    render()
    prevTime = curTime
    setTimeout(startTimer, 1000 / FPS)

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

  socket.on 'participate', (msg) ->
    player = msg.player

  socket.on 'start', ->
    start()

  socket.on 'buy', (obj) ->
    status = obj.status
    if status == 'ok'
      bakeryName = obj.bakeryName
      bakery = obj.bakery
      price = obj.price
      player.bakeries[bakery] += 1
      player.totalCookie -= price

  $(document).keydown (e) ->
    if (e.keyCode == 32 || e.keyCode == 13)
      Player.earnByClick(player)
      render()

  $('.bakery-item').click (e) ->
    id = e.target.id
    id.match(/bakery-(.+)/)
    bakeryName = RegExp.$1
    socket.emit('buy', { player: player, bakery: bakeryName })

  $('#participate-button').click (e) ->
    socket.emit('participate', { 'name': $('#player-name').val() })

