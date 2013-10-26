_ = _ || require('underscore')
Bakery = Bakery || require('./bakery')

((define) ->
  define([], ->

    newPlayer = (id, name) ->
      id: id
      name: name ? 'JoeJack'
      bakeries: Bakery.newBakeries
      totalCookie: 0
      equips: {}

    calcCPS = (bakeries, equips) ->
      _.reduce(bakeries, (r, amount, bakery) ->
        r + Bakery.calcCPS(bakery, amount, equips)
      , 0)

    calcCPC = (bakeries, equips) -> 1

    canBuy = (player, bakery) -> player.totalCookie >= price

    buy = (player, bakery) ->
      if canBuy(player, bakery)
        player.totalCookie -= Bakery.priceOf(bakery)
        player.bakeries[bakery] += 1

    sell = (player, bakery) ->
      if player.bakeries[bakery] > 0
        player.totalCookie += Bakery.priceOf(bakery)
        player.bakeries[bakery] -= 1

    gainEquip = (player, equip) ->
      player.equips[equip] = true

    earn = (player, elapsedSec) ->
      player.totalCookie += calcCPS(player.bakeries, player.equips) * elapsedSec

    earnByClick = (player) ->
      player.totalCookie += calcCPC(player.bakeries, player.equips)

    {
      newPlayer: newPlayer
      calcCPS: calcCPS
      calcCPC: calcCPC
      canBuy: canBuy
      buy: buy
      gainEquip: gainEquip
      earn: earn
      earnByClick: earnByClick
    }
  )
)(define ? if module? then (deps, factory) -> module.exports = factory() else (deps, factory) -> @['Player'] = factory())
