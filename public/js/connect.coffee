exports = this

# WebSocketサーバに接続
socket = io.connect('http://localhost:5000/')

socket.on 'connect', ->
  console.log('connect!')

socket.on 'disconnect', ->
  console.log("disconnect from server")

# メッセージ受信イベントを処理
socket.on 'message', (from, msg) ->
  alert('Received.')

exports.socket = socket