var chart;
var legend;
var chartData;

navigator.cascades.onmessage = function onmessage(message) {
	navigator.cascades.postMessage("Recieved JSON Message: " + message);
	chartData = JSON.parse(message);
	navigator.cascades.postMessage("Set chartData: " + JSON.stringify(chartData));
	
	chart = new AmCharts.AmPieChart();
    navigator.cascades.postMessage("About to set pie chart data: " + JSON.stringify(chartData));
    chart.dataProvider = chartData;
    chart.titleField = "category";
    chart.valueField = "value";
    chart.outlineColor = "#FFFFFF";
    chart.outlineAlpha = 0.8;
    chart.outlineThickness = 2;
    chart.marginTop = 0;
    chart.marginBottom = 0;
    chart.radius = 300;
    chart.labelsEnabled = false;
    chart.startDuration = 0;
    chart.pullOutDuration = 0;
    chart.pullOutRadius = 0;
    chart.balloonText = "";
    chart.colors = ["#FF0F00", "#FF9E01", "#F8FF01", "#04D215", "#639aff", "#0D52D1", "#8A0CCF", "#CD0D74"];
                
    // WRITE
    chart.write("chart");
}
/*
AmCharts.ready(function () {
	// PIE CHART
    chart = new AmCharts.AmPieChart();
    navigator.cascades.postMessage("About to set pie chart data: " + JSON.stringify(chartData));
    chart.dataProvider = chartData;
    chart.titleField = "country";
    chart.valueField = "litres";
    chart.outlineColor = "#FFFFFF";
    chart.outlineAlpha = 0.8;
    chart.outlineThickness = 2;
    chart.marginTop = 0;
    chart.marginBottom = 0;
    chart.radius = 300;
    chart.labelsEnabled = false;
    chart.startDuration = 0;
    chart.pullOutDuration = 0;
    chart.pullOutRadius = 0;
    chart.balloonText = "";
    chart.colors = ["#FF0F00", "#FF9E01", "#F8FF01", "#04D215", "#0D52D1", "#8A0CCF", "#CD0D74", "#754DEB"];
                
    // WRITE
    chart.write("chart");
});
*/