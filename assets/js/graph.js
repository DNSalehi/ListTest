var chartData = [];
var _values = [];
var _labels = [];
var splitMessage = [];

(function ($) {

navigator.cascades.onmessage = function onmessage(message) {
	navigator.cascades.postMessage("Recieved JSON Message: " + message);
	splitMessage = message.split("***");
	navigator.cascades.postMessage("splitMessage[0]: " + splitMessage[0] + " splitMessage[1]: " + splitMessage[1]);
	
	
	$("#chart").chart({
        template: "line_basic_3"
    });
    
	
	if (splitMessage[0] == "initial") {
		//Reset variables
		_values = [];
		_labels = [];
		chartData = JSON.parse(splitMessage[1]);
		navigator.cascades.postMessage("Parsed message.");
		navigator.cascades.postMessage("chartData: " + chartData);
		navigator.cascades.postMessage("chartData.length: " + chartData.length);
		//Convert Json to two seperate arrays
		for (var x in chartData) {
			navigator.cascades.postMessage("Iteration " + x);
			//If savings is negative just set it to 0. *Should change graph later to support negative values, and possibly change the fill color when its negative.*
			if (chartData[x].value < 0)
				chartData[x].value = 0;
			//Using unshift to push it in reverse order
			_values.unshift(chartData[x].value);
			_labels.unshift((chartData[x].months).toString());
		}
		//If there are less than 6 reports, insert blank labels so the graph doesnt stretch itself
		for (var y = _labels.length; y<6; y++) {
			_labels.push("");
		}
		navigator.cascades.postMessage("values: " + _values);
		navigator.cascades.postMessage("labels: " + _labels);
	} else if (splitMessage[0] == "update") {
		navigator.cascades.postMessage("Inside update.");
		var updatedMap = splitMessage[1];
		var mapSplit = updatedMap.split("^");
		navigator.cascades.postMessage("mapSplit: " + mapSplit);
		var budgetAmount = mapSplit[0];
		var budgetUsed = mapSplit[1];
		var endDate = mapSplit[2];
		var newPoint = budgetAmount - budgetUsed;
		
		navigator.cascades.postMessage("Got updatedMap in graph.js!");
		navigator.cascades.postMessage("newPoint: " + newPoint + " , endDate: " + endDate);
		navigator.cascades.postMessage("updatedMap.budgetAmount (graph.js): " + budgetAmount);
		
		_values[_values.length-1] = newPoint;
		_labels[_labels.length-1] = endDate;
		navigator.cascades.postMessage("values: " + _values);
		navigator.cascades.postMessage("labels: " + _labels);
	}
	
	//Clear previous chart
	$("#chart").chart("clear");
	navigator.cascades.postMessage("About to regenerate graph..");
	genGraph();
}

function genGraph() {
	$("#chart").chart({
		template: "line_basic_3",
		values: {
			serie1: _values,
		},
		labels: _labels
	});
}

$.elycharts.templates['line_basic_3'] = {
  type: "line",
  style: {
    "background-color": "#fefefe"
  },
  margins: [0, 0, 0, 0],
  defaultSeries: {
    rounded: false,
    stacked: true,
	fill: true,
    plotProps: {
      "stroke-width": 5
    },
    dot: true,
    dotProps: {
      stroke: "#363636",
      "stroke-width": 1.5
    },
    fillProps: {
      opacity: .15
    },
    tooltip: {
      frameProps: {
        opacity: 0.25
      }
    }
  },
  series: {
    serie1: {
      color: "#00a7de"
    }
  },
  defaultAxis: {
    labels: true,
	labelsAnchor: "start",
    labelsProps: {
      fill: "#8d8d8d",
      font: "26px Arial"
    },
	labelsMargin: 5,
    labelsDistance: -15
  },
  axis: {
    l: {
      titleProps: {
        fill: "#8d8d8d",
        font: "26px Arial"
      },
      prefix: "$",
      labels: true,
	  labelsAnchor: "start",
      labelsDistance: -1,
	  labelsMargin: 15,
      labelsSkip: 1
    }
  },
  features: {
    grid: {
      draw: true,
      forceBorder: false,
      ny: 3,
      nx: 5,
      props: {
        stroke: "#363636",
        opacity: 0.25
      }
    }
  }
};
})(jQuery);