var demodata = [
{"name":"metric 1","data":[{"timestamp":1448965800000,"value":26},{"timestamp":1448966100000,"value":23},{"timestamp":1448966400000,"value":20},{"timestamp":1448966700000,"value":19},{"timestamp":1448967000000,"value":18},{"timestamp":1448967300000,"value":20}],"id":1},
{"name":"metric 2","data":[{"timestamp":1448965800000,"value":26},{"timestamp":1448966100000,"value":23},{"timestamp":1448966400000,"value":20},{"timestamp":1448966700000,"value":19},{"timestamp":1448967000000,"value":18},{"timestamp":1448967300000,"value":20}],"id":2}
]
var seldata = demodata[0].data;
/*
function InitChart(myData) {
	var dataGroup = d3.nest()
	.key(function(d) {return "Time stamp";})
	.entries(myData);
	var color = d3.scale.category10();
	var vis = d3.select("#chartD3"),
	WIDTH = 1000,
	HEIGHT = 500,
	MARGINS = {
		top: 50,
		right: 20,
		bottom: 50,
		left: 50
	},
	lSpace = WIDTH/dataGroup.length;
	xScale = d3.time.scale.utc().range([MARGINS.left, WIDTH - MARGINS.right]).domain([d3.min(myData, function(d) {
		return d.timestamp;
	}), d3.max(myData, function(d) {
		return d.timestamp;
	})]),
	yScale = d3.scale.linear().range([HEIGHT - MARGINS.top, MARGINS.bottom]).domain([d3.min(myData, function(d) {
		return 0;
	}), d3.max(myData, function(d) {
		return d.value + 10;
	})]),
	xAxis = d3.svg.axis()
	.scale(xScale),
	yAxis = d3.svg.axis()
	.scale(yScale)
	.orient("left");

	vis.append("svg:g")
	.attr("class", "x axis")
	.attr("transform", "translate(0," + (HEIGHT - MARGINS.bottom) + ")")
	.call(xAxis);
	vis.append("svg:g")
	.attr("class", "y axis")
	.attr("transform", "translate(" + (MARGINS.left) + ",0)")
	.call(yAxis);

	var lineGen = d3.svg.line()
	.x(function(d) {
		return xScale(d.timestamp);
	})
	.y(function(d) {
		return yScale(d.value);
	})
	.interpolate("basis");
	dataGroup.forEach(function(d,i) {
		vis.append('svg:path')
		.attr('d', lineGen(d.values))
		.attr('stroke', function(d,j) { 
			return "hsl(" + Math.random() * 360 + ",100%,50%)";
		})
		.attr('stroke-width', 2)
		.attr('id', 'line_'+d.key)
		.attr('fill', 'none');
		vis.append("text")
		.attr("x", (lSpace/2)+i*lSpace)
		.attr("y", HEIGHT)
		.style("fill", "black")
		.attr("class","legend")
		.on('click',function(){
			var active   = d.active ? false : true;
			var opacity = active ? 0 : 1;
			d3.select("#line_" + d.key).style("opacity", opacity);
			d.active = active;
		})
		.text(d.key);
	});
}

jQuery(document).ready(function(){
	InitChart(seldata);
});*/