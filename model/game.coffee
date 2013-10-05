_ = require('underscore')

class Game
  constructor: ->
    @users = { 'hoge': 10, 'fuga': 20 }
    @store = new Store

  registerUser: (user) ->
    @users.push(user)

  userCount: -> _.size(@users)

class User
  constructor: ->
    @amounts = {}
    for e in Item.items
      @amounts[e] = 0

  buy: (item, store, totalCookie) ->
    return null if cookieAmount < store.prices[item]

    price = store.prices[item]

    store.amounts[item] -= 1
    user.amounts[item] += 1

    price

  cell: (item, store, totalCookie) ->

    price = store.prices[item] / 2

    store.amounts[item] += 1
    user.amounts[item] -= 1

    price

class Store

  constructor: ->
    @amounts = {}
    for e in Item.items
      @amounts[e] = 0

    @prices = Item.defaultPrices

class Item
  @items = [
    "Cursor",
    "Grandma",
    "Farm",
    "Factory",
    "Mine",
    "Shipment",
    "AlchemyLab",
    "Portal",
    "TimeMachine",
    "AntimatterCondenser"
  ]

  @defaultPrices =
    "Cursor"             : 15
    "Grandma"            : 100
    "Farm"               : 500
    "Factory"            : 3000
    "Mine"               : 10000
    "Shipment"           : 40000
    "AlchemyLab"         : 200000
    "Portal"             : 1666666
    "TimeMachine"        : 123456789
    "AntimatterCondenser": 3999999999

exports.Game = Game
exports.Item = Item
