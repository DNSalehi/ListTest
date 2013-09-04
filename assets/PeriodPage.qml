import bb.cascades 1.0
import bb.system 1.0

Page {
    id: periodPage
    //Temporarily static. Once we add the tag feature, it will be dynamic
    //property variant categoryArray: ["General","Restaurant","Groceries","Gas","Entertainment","Clothing","School","Medical","Housing"]
    //Need a dynamic value for this, generated in C++ or javascript
    //property variant valueArray: [20,15,25,22,18,28,15,19]
    property variant dataArray
        
    titleBar: TitleBar {
        title : miniDate(selectedPeriod.startDate) + " - " + miniDate(selectedPeriod.endDate)
    }
    Container {
        layout: StackLayout {}        

        WebView {
		    id: webView
		    preferredWidth: 768
		    preferredHeight: 650
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
			
			onLoadingChanged: {
			    if (loadRequest.status == WebLoadStatus.Started) {
                    console.log("Load started.")
                    //sendWebViewMessage()
                } else if (loadRequest.status == WebLoadStatus.Succeeded) {
                    console.log("Load finished.")
                    sendWebViewMessage()
                } else if (loadRequest.status == WebLoadStatus.Failed) {
                    console.log("Load failed.")
                }   
			}
			
			onMessageReceived: {
			    console.log("Message received: " + message.data)   
			}
        } 

        
        Legend {
            id: legend
        }  
    }
    
    actions: [
        ActionItem {
        	id: viewPeriodExpenses
        	title: "Past expenses"
        	imageSource: "asset:///images/ic_view_details.png"
        	ActionBar.placement: ActionBarPlacement.OnBar
        	onTriggered: {
        	    periodExpensesPage = periodExpensesPageDefinition.createObject()
        	    reportsPage.push(periodExpensesPage)
        	    budgetApp.updatePeriodExpensesListView(selectedPeriod.startDate,selectedPeriod.endDate)
        	}
        }
    ]
    
    attachedObjects: [
        ComponentDefinition {
            id: periodExpensesPageDefinition
            source: "PeriodExpenses.qml"
        },
        SystemToast {
            id: noInfoToast
            body: "This period has no expenses to analyze."
        }
    ]
    
    function showInfoToast() {
        noInfoToast.show()   
    }
    
    function miniDate(date) {
        var charCheck = date.charAt(0)
        if (!isNaN(charCheck)) {
            var splitDate = date.split(".")
    		        
    		if (splitDate[0] == "01")
    		    splitDate[0] = "Jan"
    		else if (splitDate[0] == "02")
    		    splitDate[0] = "Feb"
    		else if (splitDate[0] == "03")
    		    splitDate[0] = "Mar"
    		else if (splitDate[0] == "04")
    		    splitDate[0] = "Apr"
    		else if (splitDate[0] == "05")
    		    splitDate[0] = "May"
    		else if (splitDate[0] == "06")
    		    splitDate[0] = "Jun"
    		else if(splitDate[0] == "07")
    		    splitDate[0] = "Jul"
    		else if(splitDate[0] == "08")
    		    splitDate[0] = "Aug"
    		else if(splitDate[0] == "09")
    		    splitDate[0] = "Sep"
    		else if(splitDate[0] == "10")
    		    splitDate[0] = "Oct"
    		else if(splitDate[0] == "11")
    		    splitDate[0] = "Nov"
    		else if(splitDate[0] == "12")
    		    splitDate[0] = "Dec"
    		    
    		return splitDate[0] + " " + splitDate[1] + " " + splitDate[2]
        } else {
            var splitDate = date.split(" ")
            return splitDate[1] + " " + splitDate[2] + " " + splitDate[3]
        }
    }
    
    function setArrayValue(prevArray) {
        dataArray = prevArray   
    }
    
    function sendWebViewMessage() {
        console.log("Sending out msg: " + JSON.stringify(dataArray))
        webView.postMessage(JSON.stringify(dataArray))   
        //Set the percentages
        legend.setPercentages()
    }
}