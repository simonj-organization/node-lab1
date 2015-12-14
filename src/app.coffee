express = require 'express'
morgan = require 'morgan' 
app = express()
metrics = require './metrics'
user = require './user'
userMetrics = require './user-metrics'
session = require 'express-session'
LevelStore = require('level-session-store')(session)
app.set 'port', 1337
app.set 'views', "#{__dirname}/../views"
app.set 'view engine', 'jade'
app.use require('stylus').middleware(
  src: __dirname + '/public'
  force: true
  compile: (str, path) ->
    stylus(str).set('filename', path).set 'compress', true
)
app.use '/', express.static "#{__dirname}/../public"
app.use require('body-parser')()
app.use morgan 'dev'
app.use session
	secret: 'MyAppSecret'
	store: new LevelStore '../db/sessions' 
	resave: true
	saveUninitialized: true


authCheck = (req, res, next) -> 
	unless req.session.loggedIn == true
		res.redirect '/login' 
	else
		next()


app.get '/', authCheck, (req, res) ->
	res.render 'index',
		name: req.session.username
		title: "My title could go here to be inserted in view"


app.get '/userMetrics.json', authCheck, (req, res) ->
	userMetrics.get req.session.username, (err, value) ->
		if err
			if err.notFound
				res.status(404).json "Not found"
			else
				res.status(500).json err
		else
			res.status(200).json value


app.get '/metric/:id.json', authCheck, (req, res) ->
	userMetrics.get req.session.username, (err, value) ->
		if err
			res.status(500).json err
		else
			id = parseInt req.params.id 
			if value.indexOf(id)<0
				res.status(401).json "This is not your metrics"
			else
				metrics.get req.params.id, (err, value) ->
					if err
						if err.notFound then res.status(404).json "Not found"
						if !err.notFound then res.status(500).json err
					res.status(200).json value

app.delete '/metric/:id.json', authCheck, (req, res) ->
	metrics.delete req.params.id, (err) ->
		if err then res.status(500).json err
		res.status(200).send "Metrics deleted"


app.post '/metric', authCheck, (req, res) ->
	metrics.save null, req.body, (id, err) ->
		if err
			console.log err
			res.status(500).json err
		else
			userMetrics.add req.session.username, id, (err) ->
				if err
					console.log err
					res.status(500).json err
				else
					res.status(201).send "Metrics saved"


app.get '/metric/new', authCheck, (req, res) ->
	res.render 'new',


app.get '/user/:username.json', authCheck, (req, res) ->
	if req.params.username != req.session.username 
		res.status(401).json "This is not your user"
	user.get req.params.username, (err, value) ->
		if err
			if err.notFound then res.status(404).json "Not found"
			if !err.notFound then res.status(500).json err
		res.status(200).json value

app.delete '/user/:username.json', authCheck, (req, res) ->
	if req.params.username != req.session.username 
		res.status(401).json "This is not your user"
	user.delete req.params.username, (err) ->
		if err then res.status(500).json err
		res.status(200).send "User deleted"



app.get '/login', (req, res) -> 
	res.render 'login'


app.post '/login', (req, res) ->
	console.log req.body
	user.get req.body.username, (err, data) ->
		if err
			console.log err
			if err.notFound
				error = "User was not found"
			else
				error = "An error occured"
			res.render 'login',
				error: error
		else
			if req.body.password == data.password
				req.session.loggedIn = true 
				req.session.username = data.username 
				res.redirect '/'
			else
				res.render 'login',
				error: "Incorrect password"


app.get '/signup', (req, res) -> 
	res.render 'signup',


app.post '/signup', (req, res) ->
	if req.body.username && req.body.password 
		#Check is user doe not exist already
		username = req.body.username
		user.get username, (err, data) ->
			if err && err.notFound
				user.save req.body, (err, data) ->
					if err
						console.log err 
						res.render 'signup',
							error: "An error occured"
					else
						metrics = [1,2]
						userMetrics.save username, metrics, (err, value) ->
							if err
								console.log err 
								res.render 'signup',
									error: "An error occured"
							else
								res.render 'login',
									error: "User created"
			else
				res.render 'signup',
					error: "User already exist"
	else
		res.render 'signup',
			error: "Most provide username and password"


app.get '/logout', (req, res) -> 
	delete req.session.loggedIn 
	delete req.session.username
	res.redirect '/login'


app.listen app.get('port'), () ->
	console.log "listening on #{app.get 'port'}"