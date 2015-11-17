// Import a module
var http = require('http')
var users = require('./src/users.js')
var url = require('url')

// Declare an http server
http.createServer(function (req, res) {
	var requestURL = url.parse(req.url, true);
	var callback = function(user){
		res.writeHead(200, {'Content-Type': 'text/html'});
	  	res.end('<body><html><h1>User '+user.first_name+' Saved!</h1></body></html>');
	}
	if(requestURL.pathname == "/save"){
		var user = {	
				first_name: requestURL.query.firstname,
				last_name: requestURL.query.lastname
			};
		users.save(user, callback);
	}else if(parseInt(requestURL.pathname.replace('/',''))){
		var id  = parseInt(requestURL.pathname.replace('/',''));
		var user = users.get(id, function(){console.log("USER RETRIEVED")});
		res.writeHead(200, {'Content-Type': 'text/plain'});
	  	res.end(JSON.stringify(user));
	}else if(req.method == "GET"){
		// Write a response header
	  	res.writeHead(200, {'Content-Type': 'text/html'});
	  	// Write a response content
	  	res.end('<body><html><form method="GET" action="/save">First name:<br><input type="text" name="firstname"><br>Last name:<br><input type="text" name="lastname"></br><input type="submit" value="Submit"></form></html></body>');
	}
  	
// Start the server
}).listen(1337, '127.0.0.1')