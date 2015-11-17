var users = require('../lib/src/users.js');
var should = require('should');

describe('Test Set', function() {
	it("It should return id: 42, first_name: Tim and last_name: Howard", function () {
		users.save({first_name: 'Tim', last_name: 'Howard'},function (user) {
			user.id.should.equal(42);
			user.first_name.should.equal('Tim');
			user.last_name.should.equal('Howard');
		});
	});
});

describe('Test Get', function() {
	it("It should return id: 43 first_name: Simon and last_name: Jaspar", function () {
		var user = users.get(43);
		user.id.should.equal(43);
		user.first_name.should.equal('Simon');
		user.last_name.should.equal('Jaspar');
	});
});