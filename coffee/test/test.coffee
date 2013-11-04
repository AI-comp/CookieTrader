require '../app/app'
Spooky = require 'spooky'

initialize = (done) ->
  spooky = new Spooky
    child:
      transport: 'http'
    casper:
      logLevel: 'debug'
      verbose: true,
    (err) ->
      if err
        e = new Error('Failed to initialize SpookyJS')
        e.details = err
        throw e

      spooky.on 'error', (e, stack) ->
        console.error(e)
        if stack
          console.log(stack)
      spooky.on 'console', (line) ->
        console.log(line)
        if line.match(/FAIL/)
          spooky.fails.push(line)
      spooky.on 'log', (log) ->
        if log.space == 'remote'
          console.log log.message.replace(/\- .*/, '')

      spooky.debug = true
      spooky.setUpAndRun = (done) ->
        spooky.fails = []
        spooky.once 'run.complete', ->
          done if spooky.fails.length == 0 then null else new Error(spooky.fails)
        spooky.run ->
          this.test.done()

      done()
  return spooky

describe 'Frontend tests', ->
  spooky = null
  before (done) ->
    spooky = initialize(done)
  after ->
    spooky.destroy()

  it 'Open top page', (done) ->
    spooky.start 'http://localhost:5000'
    spooky.then ->
      @test.assertHttpStatus(200, 'successfully received 200 OK')
    spooky.setUpAndRun(done)

