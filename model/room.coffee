_ = require('underscore')

Player = require('../public/js/player')
Bakery = require('../public/js/bakery')
Equip = require('../public/js/equip')

class Room

  constructor: ->
    @_audienceCount = 0
    @_players = {}

  enterAudience: ->
    @_audienceCount += 1

  leaveAudience: ->
    @_audienceCount -= 1

  participatePlayer: (name) ->
    id = generateID
    player = Player.newPlayer(id, name)
    @_players[id] = player

  resumePlayer: (id) -> @_players[id]

  isReady: -> _.size(@_players) == @_audienceCount

  allPlayers: -> @_players

module.exports = Room
