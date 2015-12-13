###
db = require('./db') "#{__dirname}/../db/metrics"
###
levelup = require 'levelup' 
db = levelup '../db/metrics', 'json'

module.exports =
###
	get()
	------

	Returns some hard coded metrics
###
get: (id, callback) ->
	db.get id, callback
###
	save()
	-------
	Save some metrics with a given id

	Parameters:
	'id': An integer defining a batch of metrics
	'metrics': An array of objects with a timestam and a value
	'callback': Callback function called at the oend or on error
###
save: (id, metrics, callback) ->
	db.put id, metrics, callback

###
	delete()
	-------
	Delete the metrics with a given id

	Parameters:
	'id': An integer defining a batch of metrics
	'callback': Callback function called at the end or on error
###
delete: (id, callback) ->
	db.del id, callback