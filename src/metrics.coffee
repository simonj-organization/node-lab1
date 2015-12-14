levelup = require 'levelup' 
db = levelup '../db/metrics', 'json'

metricNextKey = null


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
	if !id
		if !metricNextKey
			console.log "Init next Key"
			ks = db.createKeyStream
				reverse: true
				limit: 1
			ks.on 'data', (data) ->
				if data
					metricNextKey = parseInt data
				else
					metricNextKey = 0
				metricNextKey++
				console.log metricNextKey
				metrics.id = metricNextKey
				db.put metricNextKey, metrics, (err) ->
					callback(metrics.id, err)
		else
			metricNextKey++
			console.log metricNextKey
			metrics.id = metricNextKey
			db.put metricNextKey, metrics, (err) ->
				callback(metrics.id, err)
	else
		metrics.id = id
		db.put id, metrics, (err) ->
			callback(metrics.id, err)


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
