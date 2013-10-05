class Player
    constructor: (@totalCookie, @currentCps) ->
        @cookiePerClick = 1
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

    bake: (elapsedSec) ->
        @totalCookie += @currentCps * elapsedSec

    increaseCps: (cps) ->
        @currentCps += cps

    clickCookie: ->
        @totalCookie += @cookiePerClick

    buy: (bakeryName, price) ->
        @bakeries[bakeryName] += 1
        @totalCookie          -= price

this.Player = Player
