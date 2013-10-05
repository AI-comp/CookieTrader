class CookieBakery
    constructor: (@name, @price, @cps, @count, @ownedCount) ->

    sumCps: ->
        @cps * @ownedCount
