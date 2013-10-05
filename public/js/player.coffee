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


class Player extends Base
  constructor: ->
    super()
    @hookable('totalCookie')

    @bakeries = {
      'Cursor':              0,
      'Grandma':             0,
      'Farm':                0,
      'Factory':             0,
      'Mine':                0,
      'Shipment':            0,
      'AlchemyLab':          0,
      'Portal':              0,
      'TimeMachine':         0,
      'AntimatterCondenser': 0,
    }

    @totalCookie = 0
    @cookiePerClick = 1
    @currentCps = 10

  bake: (elapsedSec) ->
    @totalCookie += @currentCps * elapsedSec

  increaseCps: (cps) ->
    @currentCps += cps

  clickCookie: ->
    @totalCookie += @cookiePerClick

  buy: (bakeryName, price) ->
    @bakeries[bakeryName] += 1
    @totalCookie      -= price

this.Player = Player
