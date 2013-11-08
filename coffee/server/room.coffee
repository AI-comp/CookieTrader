_ = require('underscore')

Player = require('./player')
Bakery = require('./bakery')
Equip = require('./equip')

seedID = 1
generateID = -> seedID++

class Room

  constructor: ->
    @_audienceCount = 0
    # FIXME: debug player hoge
    @_players = {}
    @_globalBakeries = Bakery.newBakeries()

  enterAudience: ->
    console.log('audience++')
    @_audienceCount += 1

  leaveAudience: ->
    console.log('audience--')
    @_audienceCount -= 1

  participatePlayer: (name) ->
    console.log('player++')
    id = generateID()
    player = Player.newPlayer(id, name)
    @_players[id] = player

  resumePlayer: (id) -> @_players[id]

  isReady: -> _.size(@_players) == @_audienceCount

  allPlayers: -> _.values(@_players)

  player: (name) -> @_players[name]

  updatePlayer: (player) ->
    @_players[player.id] = player

  buyBakery: (player, bakery) ->
    price = Bakery.calcPrice(@_globalBakeries, bakery)
    if player.totalCookie >= price
      player.totalCookie -= price
      player.bakeries[bakery] += 1
      @_globalBakeries[bakery] += 1
      price
    else
      null

  sellBakery: (player, bakery) ->
    price = Math.floor(Bakery.calcPrice(@_globalBakeries, bakery) / 2)
    if player.bakeries[bakery] >= 1
      player.totalCookie += price
      player.bakeries[bakery] -= 1
      @_globalBakeries[bakery] -= 1
      price
    else
      null

  globalBakeries: -> @_globalBakeries

module.exports = Room
