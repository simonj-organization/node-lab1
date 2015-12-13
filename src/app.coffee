express = require 'express'
morgan = require 'morgan' 
app = express()
metrics = require './metrics'

app.set 'port', 1337
app.set 'views', "#{__dirname}/../views"
app.set 'view engine', 'jade'
app.use '/', express.static "#{__dirname}/../public"
app.use require('body-parser')()
app.use morgan 'dev'


app.get '/', (req, res) ->
	res.render 'index',
		locals:
			title: "My title could go here to be inserted in view"

app.get '/metrics.json', (req, res) ->
	#TODO return all the users metrics
	res.json metrics.get()

app.get '/hello/:name', (req, res) ->
	res.status(200).json req.params.name

app.get '/metric/:id.json', (req, res) ->
	metrics.get req.params.id, (err, value) ->
		if err
			if err.notFound then res.status(404).json "Not found"
			if !err.notFound then res.status(500).json err
		res.status(200).json value

app.delete '/metric/:id.json', (req, res) ->
	metrics.delete req.params.id, (err) ->
		if err then res.status(500).json err
		res.status(200).send "Metrics deleted"

app.post '/metric', (req, res) ->
	metrics.save req.params.id, req.body, (err) ->
		if err
			console.log err
			res.status(500).json err
		else
			res.status(201).send "Metrics saved"

app.listen app.get('port'), () ->
	console.log "listening on #{app.get 'port'}"