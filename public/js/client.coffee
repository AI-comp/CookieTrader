$ ->
  pretty = (val) ->
    val = Math.floor(val)
    num = new String(val)
    while(true)
      break if num is (num = num.replace(/^(-?\d+)(\d{3})/, "$1,$2"))
    num

  FPS = 10
  TYPING_CHARACTERS = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'

  player = null
  prevTime = null
  started = false
  typingText = null
  nextCode = null

  textGen = ->
    kinds = TYPING_CHARACTERS.length
    for i in [0...10]
      typingText += TYPING_CHARACTERS.charAt(Math.floor(Math.random() * kinds))

  #client info
  render = ( ->
    cookieElem = $('#my-total-cookie')
    cpsElem = $('#my-cps')
    typingElem = $('#typing-text')
    ->
      cps = Player.calcCPS(player.bakeries, player.equips)
      cookieElem.text(pretty(player.totalCookie))
      cpsElem.text(pretty(cps))
      #cpsElem.text(pretty(cps)+'.'+(Math.floor(cps*10)%10))
      typingElem.text(typingText)
      for bakery, amount of player.bakeries
        $("#my-#{bakery} .amount").text(amount)
        if amount >= 1
          $('#my-'+bakery+' .bakery-sell').css("visibility", "visible")
        else
          $('#my-'+bakery+' .bakery-sell').css("visibility", "hidden")
  )()

  #server info
  renderInfo = (info) ->
    bakeries = info.bakeries
    for bakery, amount of bakeries
      $("#bakery-#{bakery} .amount").text(amount)
      $('#bakery-'+bakery+' .bakery-price').text(pretty(Bakery.calcPrice(bakeries, bakery)))
      if Math.floor(Bakery.calcPrice(bakeries, bakery)) <= player.totalCookie
        $('#bakery-'+bakery+' .bakery-price').css("color","#6f6")
      else
        $('#bakery-'+bakery+' .bakery-price').css("color","#f66")

  startTimer = () ->
    curTime = new Date().getTime()
    Player.earn(player, (curTime - prevTime) / 1000)
    render()
    prevTime = curTime
    setTimeout(startTimer, 1000 / FPS)

  start = ->
    typingText = ''
    textGen()
    nextCode = typingText.charCodeAt(0)
    prevTime = new Date().getTime()
    startTimer()
    started = true
    setInterval( ->
      socket.emit('getInfo', { player: player })
    , 1000)

  # Connect the WebSocket server
  socket = io.connect(window.location.origin)

  socket.on 'connect', ->
    console.log('connect!')

  socket.on 'disconnect', ->
    console.log("disconnect from server")

  socket.on 'participate', (obj) ->
    player = obj.player

  socket.on 'getInfo', (obj) ->
    renderInfo(obj)

  socket.on 'start', ->
    console.log('start!')
    start()

  socket.on 'buy', (obj) ->
    status = obj.status
    if status == 'ok'
      bakeryName = obj.bakeryName
      bakery = obj.bakery
      price = obj.price
      player.bakeries[bakery] += 1
      player.totalCookie -= price

  socket.on 'sell', (obj) ->
    status = obj.status
    if status == 'ok'
      bakeryName = obj.bakeryName
      bakery = obj.bakery
      price = obj.price
      player.bakeries[bakery] -= 1
      player.totalCookie += price / 2

  $(document).keydown (e) ->
    return unless started

    if (e.keyCode == nextCode)
      Player.earnByClick(player)
      typingText = typingText.substr(1)
      textGen() if typingText is ''
      nextCode = typingText.charCodeAt(0)
      render()

  $('.bakery-item').click (e) ->
    return unless started
    id = e.currentTarget.id
    id.match(/bakery-(.+)/)
    bakeryName = RegExp.$1
    socket.emit('buy', { player: player, bakery: bakeryName })

  $('.my-item').click (e) ->
    return unless started
    id = e.currentTarget.id
    id.match(/my-(.+)/)
    bakeryName = RegExp.$1
    socket.emit('sell', { player: player, bakery: bakeryName })

  $('#participate-button').click (e) ->
    socket.emit('participate', { 'name': $('#player-name').val() })
    $('#cover').remove()

