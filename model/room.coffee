_ = require('underscore')

Player = require('../public/js/player')
Bakery = require('../public/js/bakery')
Equip = require('../public/js/equip')

seedID = 1
generateID = -> seedID++

class Room

  constructor: ->
    @_audienceCount = 0
    # FIXME: debug player hoge
    @_players = {}

  enterAudience: ->
    console.log('audience++');
    @_audienceCount += 1

  leaveAudience: ->
    console.log('audience--');
    @_audienceCount -= 1

  participatePlayer: (name) ->
    console.log('player++');
    id = generateID
    player = Player.newPlayer(id, name)
    @_players[id] = player

  resumePlayer: (id) -> @_players[id]

  isReady: -> _.size(@_players) == @_audienceCount

  allPlayers: -> _.values(@_players)

  player: (name) -> @_players[name]

  updatePlayer: (player) ->
    @_players[player.id] = player

module.exports = Room
