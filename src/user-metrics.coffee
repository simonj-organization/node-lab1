levelup = require 'levelup' 
db = levelup '../db/user-metrics', 'json'

module.exports =

add: (username, id, callback) ->
	db.get username, (err, value) ->
		if err
			if err.notFound
				newValue = [id]
				db.put username, newValue, callback
			else
				res.status(500).json err
		else
			value.push(id)
			db.put username, value, callback

get: (username, callback) ->
	db.get username, callback

save: (username, metrics, callback) ->
	db.put username, metrics, callback

delete: (username, callback) ->
	db.del username, callback
