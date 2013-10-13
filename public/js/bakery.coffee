((define) ->
  define([], ->

    newBakeries =
      'Cursor':              0
      'Grandma':             0
      'Farm':                0
      'Factory':             0
      'Mine':                0
      'Shipment':            0
      'AlchemyLab':          0
      'Portal':              0
      'TimeMachine':         0
      'AntimatterCondenser': 0

    baseCPSs =
      'Cursor':              0.1
      'Grandma':             0.5
      'Farm':                2
      'Factory':             10
      'Mine':                40
      'Shipment':            100
      'AlchemyLab':          400
      'Portal':              6666
      'TimeMachine':         98765
      'AntimatterCondenser': 999999

    prices =
      'Cursor':              15
      'Grandma':             100
      'Farm':                500
      'Factory':             3000
      'Mine':                10000
      'Shipment':            40000
      'AlchemyLab':          200000
      'Portal':              1666666
      'TimeMachine':         123456789
      'AntimatterCondenser': 3999999999

    calcCPS = (bakery, amount, equips) -> baseCPSs[bakery] * amount

    priceOf = (bakery) -> prices[bakery]

    raisePrice = (bakery) -> prices[bakery] *= 1.1

    reducePrice = (bakery) -> prices[bakery] /= 1.1

    {
      newBakeries: newBakeries
      calcCPS: calcCPS
      priceOf: priceOf
      raisePrice: raisePrice
      reducePrice: reducePrice
    }
  )
)(define ? if module? then (deps, factory) -> module.exports = factory() else (deps, factory) -> @['Bakery'] = factory())
