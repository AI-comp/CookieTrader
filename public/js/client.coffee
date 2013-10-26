$ ->
  pretty = (val) ->
    '' + Math.floor(val)

  FPS = 10
  TYPING_CHARACTERS = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'

  player = null
  prevTime = null
  started = false
  typingText = null
  nextCode = null

  textGen = ->
    kinds = TYPING_CHARACTERS.length
    typingText += TYPING_CHARACTERS.charAt(Math.floor(Math.random() * kinds))
    nextCode = typingText.charCodeAt(0)

  render = ( ->
    cookieElem = $('#my-total-cookie')
    cpsElem = $('#my-cps')
    typingElem = $('#typing-text')
    ->
      cookieElem.text(~~player.totalCookie)
      cpsElem.text(Player.calcCPS(player.bakeries, player.equips))
      typingElem.text(typingText)
  )()

  startTimer = () ->
    curTime = new Date().getTime()
    Player.earn(player, (curTime - prevTime) / 1000)
    render()
    prevTime = curTime
    setTimeout(startTimer, 1000 / FPS)

  start = ->
    typingText = ''
    textGen() for i in [0...10]
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
    if (e.keyCode == nextCode)
      Player.earnByClick(player)
      typingText = typingText.substr(1)
      textGen()
      render()

  $('.bakery-item').click (e) ->
    id = e.target.id
    id.match(/bakery-(.+)/)
    bakeryName = RegExp.$1
    socket.emit('buy', { player: player, bakery: bakeryName })

  $('#participate-button').click (e) ->
    socket.emit('participate', { 'name': $('#player-name').val() })

