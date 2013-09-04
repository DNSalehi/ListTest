import bb.cascades 1.0

WebView {
    leftMargin: 0
    topMargin: 0
    topPadding: 0
    leftPadding: 0
    id: webView
    html: "<html><head>" +
    //Pass variables
    "<script type='text/javascript'>var _values =  [35,12,16,60,40,75];var	_labels = ['Sep 01', 'Oct 01', 'Nov 01', 'Dec 01', 'Jan 01'];</script>" +
    "<script type='text/javascript' src='assets/js/jquery-1.8.3.min.js'></script>" +
    "<script type='text/javascript' src='assets/js/raphael-min.js'></script></head>" +
    "<script type='text/javascript' src='assets/js/elycharts.min.js'></script></head>" +
    "<script type='text/javascript' src='assets/js/graph.js'></script>" +
    "<body style='margin:0; padding:0;'>" + 
    "<div id='chart' style='width:768px; height:554px;'></div>" + 
    "</body></html>"
}   