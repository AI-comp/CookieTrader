class Base
  constructor: -> @__hooks = {}

  define: (prop, desc) ->
    Object.defineProperty(@, prop,
      set: (v) =>
        if @__hooks[prop]?
          h(v) for h in @__hooks[prop]
        desc.set(v)
      get: -> desc.get()
    )

  hookable: (prop) ->
    @define(prop,
      set: (v) => @['_'+prop] = v
      get: => @['_'+prop]
    )

  hook: (prop, h) ->
    @__hooks[prop] ||= []
    @__hooks[prop].push(h)


class Bakery extends Base
  constructor: (@name, @price, @baseCps, @calcCps) ->
    super()
    @hookable('ownedCount')

    @count = 0
    @ownedCount = 0

  cps: -> @calcCps()

  @cursor: ->
    new Bakery('Cursor', 15, 0.1, (player) ->
      @baseCps * @ownedCount
    )

  @grandma: ->
    new Bakery('Grandma', 100, 0.5, (player) ->
      @baseCps * @ownedCount
    )

  @farm: ->
    new Bakery('Farm', 500, 2, (player) ->
      @baseCps * @ownedCount
    )

  @factory: ->
    new Bakery('Factory', 3000, 10, (player) ->
      @baseCps * @ownedCount
    )

  @mine: ->
    new Bakery('Mine', 10000, 40, (player) ->
      @baseCps * @ownedCount
    )

  @shipment: ->
    new Bakery('Shipment', 40000, 100, (player) ->
      @baseCps * @ownedCount
    )

  @alchemyLab: ->
    new Bakery('AlchemyLab', 200000, 400, (player) ->
      @baseCps * @ownedCount
    )

  @portal: ->
    new Bakery('Portal', 1666666, 6666, (player) ->
      @baseCps * @ownedCount
    )

  @timeMachine: ->
    new Bakery('TimeMachine', 123456789, 98765, (player) ->
      @baseCps * @ownedCount
    )

  @antimatterCondenser: ->
    new Bakery('AntimatterCondenser', 3999999999, 999999, (player) ->
      @baseCps * @ownedCount
    )


class Player extends Base
  constructor: ->
    super()
    @hookable('totalCookie')
    @hookable('currentCps')

    @bakeries = {
      'Cursor':              Bakery.cursor()
      'Grandma':             Bakery.grandma()
      'Farm':                Bakery.farm()
      'Factory':             Bakery.factory()
      'Mine':                Bakery.mine()
      'Shipment':            Bakery.shipment()
      'AlchemyLab':          Bakery.alchemyLab()
      'Portal':              Bakery.portal()
      'TimeMachine':         Bakery.timeMachine()
      'AntimatterCondenser': Bakery.antimatterCondenser()
    }

    @totalCookie = 0
    @cookiePerClick = 1
    @currentCps = 0

  bake: (elapsedSec) ->
    @totalCookie += @currentCps * elapsedSec

  increaseCps: (cps) ->
    @currentCps += cps

  clickCookie: ->
    @totalCookie += @cookiePerClick

  buy: (bakeryName, price) ->
    @totalCookie          -= price
    bakery = @bakeries[bakeryName]
    bakery.ownedCount += 1
    cps = 0
    for k,v of @bakeries
      console.log(v)
      cps += v.cps()
    @currentCps = cps



this.Player = Player
