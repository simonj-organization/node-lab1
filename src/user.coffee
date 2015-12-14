levelup = require 'levelup' 
db = levelup '../db/users', 'json'

module.exports =

get: (username, callback) ->
	db.get username, callback

save: (user, callback) ->
	db.put user.username, user, callback

delete: (username, callback) ->
	db.del username, callback
