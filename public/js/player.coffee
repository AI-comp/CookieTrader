class Player
    constructor: (@totalCookie, @currentCps, @bakeries) ->

    bake: ->
        @totalCookie += @currentCps

    increaseCps: (cps) ->
        @currentCps += cps

    clickCookie: ->
        this.bake()
        this.update()

    buy: (bakeryName, price) ->
        @bakeries[bakeryName] += 1
        @totalCookie          -= price

    update: ->
        $('h2.totalCookie').text(@totalCookie)

cycle = (f, time) => setInterval(f, time)

$( ->
    bakeries = {
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

    player = new Player(0, 10, bakeries)

    $('h2.totalCookie').click( ->
        player.clickCookie()
    )

    for key, value of bakeries
        $('input.' + key).click( ->
            player.buy(key, 10)
        )

    cycle( ->
        player.bake()
        player.update()
    , 1000)
)
