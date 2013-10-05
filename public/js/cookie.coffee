class Cookie
    constructor: (@cookieAmount, @currentCps) ->

    getCookieAmount: ->
        @cookieAmount

    getCurrentCps: ->
        @currentCps

    bake: ->
        @cookieAmount += @currentCps

    increaseCps: (cps) ->
        @currentCps += cps

    clickCookie: ->
        increaseCps(@currentCps)

    update: ->
        $('h2.cookieAmount').text(@cookieAmount)

cycle = (f, time) => setInterval(f, time)

$( ->
    cookie = new Cookie(0, 0)
    cookie.increaseCps(1)

    cycle( ->
        cookie.bake()
    , 1000)
    cycle( ->
        cookie.update()
    , 1000)
)
