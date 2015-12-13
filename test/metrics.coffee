{exec} = require 'child_process'
should = require 'should'

describe "metrics", () ->

  metrics = null
  before (next) ->
    exec "rm -rf #{__dirname}/../db/metrics && mkdir #{__dirname}/../db/metrics", (err, stdout) ->
      metrics = require '../lib/metrics'
      next err

  it "get a metric", (next) ->
    metrics.save '1', [
      timestamp:(new Date '2015-11-04 14:00 UTC').getTime(), value:23
     ,
      timestamp:(new Date '2015-11-04 14:10 UTC').getTime(), value:56
    ], (err) ->
      return next err if err
      metrics.get '1', (err, metrics) ->
        return next err if err
        # do some tests here on the returned metrics
        metrics[0].should.have.property 'value', 23
        metrics[1].should.have.property 'value', 56
        next()
  it "delete a metric", (next) ->
    metrics.delete '1', (err) ->
      return next err if err
      # do some tests here on the returned error
      metrics.get '1', (err, metrics) ->
        err.notFound.should.equal true
        console.log err
        next()