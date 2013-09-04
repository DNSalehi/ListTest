import bb.cascades 1.0

WebView {
    id: webView
	leftMargin: 0
	topMargin: 0
	topPadding: 0
	leftPadding: 0
	html: "<html><head>" +
	//Pass variables
	"<script type='text/javascript'></script>" +
	"<script type='text/javascript' src='assets/js/jquery-1.8.3.min.js'></script>" +
	"<script type='text/javascript' src='assets/js/raphael-min.js'></script></head>" +
	"<script type='text/javascript' src='assets/js/amcharts.js'></script></head>" +
	"<script type='text/javascript' src='assets/js/pie.js'></script>" +
	"<body style='margin:0; padding:0;'>" + 
	"<div id='chart' style='width:768px; height:650px;'></div>" + 
	"</body></html>"
	
	onMessageReceived: {
	    console.log(message.data)   
	}
} 



