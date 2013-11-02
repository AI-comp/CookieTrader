Spooky = require 'spooky'
should = require('chai').should()
expect = require('chai').expect

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
      spooky.debug = true
      spooky.fails = []
      done()
  spooky.on 'error', (e, stack) ->
    console.error(e)
    if stack
      console.log(stack)
  
  spooky.on 'console', (line) ->
    console.log(line)
    if line.match(/FAIL/)
      spooky.fails.push(line)
  
  spooky.on 'hello', (greeting) ->
    console.log(greeting)
  
  spooky.on 'log', (log) ->
    if log.space == 'remote'
      console.log log.message.replace(/\- .*/, '')

describe 'Frontend tests', ->
  spooky = null
  fails = []
  ok = true

  before (done) ->
    spooky = initialize(done)
  after ->
    spooky.removeAllListeners()
    spooky.destroy()
  afterEach ->
    @test.error(new Error(fails)) unless ok

  it 'Hello', (done) ->
    spooky.start 'http://en.wikipedia.org/wiki/Spooky_the_Tuff_Little_Ghost'
    spooky.then ->
      @emit 'hello', 'Hello, from ' + @evaluate ->
        document.title
      @test.assertHttpStatus(199, 'successfully received 200 OK')
      @test.assertHttpStatus(200, 'successfully received 200 OK')

    spooky.on 'run.complete', ->
      if spooky.fails.length > 0
        console.log(@test)
        fails.push(spooky.fails)
        ok = false
      done()
    spooky.run ->
      @test.done()


  it 'Hello2', (done) ->
    spooky.start 'http://en.wikipedia.org/wiki/Spooky_the_Tuff_Little_Ghost'
    spooky.then ->
      @emit 'hello', 'Hello, from ' + @evaluate ->
        document.title
      @test.assertHttpStatus(199, 'successfully received 200 OK')
      @test.assertHttpStatus(200, 'successfully received 200 OK')

    spooky.on 'run.complete', ->
      if spooky.fails.length > 0
        console.log(@test)
        fails.push(spooky.fails)
        ok = false
      done()
    spooky.run ->
      @test.done()

