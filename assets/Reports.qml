import bb.cascades 1.0
import bb.cascades.advertisement 1.0

NavigationPane {
    id: reportsPage
    property variant accountPage
    property variant settingsPage
    property variant periodPage
    property variant selectedPeriod
    property variant periodExpensesPage
    property string startDateArray
    property variant dataArray
    property string graphDataArray: ""
    
    Page {
        Container {
            layout: DockLayout {}
            
	        Container {
	            layout: StackLayout {}
	            topPadding: 0
	            leftPadding: 0
	            
	            WebView {
	                id: webView
	                leftMargin: 0
	                topMargin: 0
	                topPadding: 0
	                leftPadding: 0
	                html: "<html><head>" +
	                //Pass variables
	                "<script type='text/javascript' src='assets/js/jquery-1.8.3.min.js'></script>" +
	                "<script type='text/javascript' src='assets/js/raphael-min.js'></script></head>" +
	                "<script type='text/javascript' src='assets/js/elycharts.min.js'></script></head>" +
	                "<script type='text/javascript' src='assets/js/graph.js'></script>" +
	                "<body style='margin:0; padding:0;'>" + 
	                "<div id='chart' style='width:768px; height:554px;'></div>" + 
	                "</body></html>"
	                
	                onLoadingChanged: {
	                    if (loadRequest.status == WebLoadStatus.Started) {
	                        console.log("Load started.")
	                        //sendWebViewMessage()
	                    } else if (loadRequest.status == WebLoadStatus.Succeeded) {
	                        console.log("Load finished.")
	                        //Connect the updateGraph signal called whenever the periods are modified to updating the graph and regenerating it
					        budgetApp.updateGraph.connect(updateGraph)
					        budgetApp.reloadWeb.connect(reloadWebView)
					        console.log("Finished getting data, sending Json array.")   
					        sendWebViewMessage()
	                    } else if (loadRequest.status == WebLoadStatus.Failed) {
	                        console.log("Load failed.")
	                    }   
	               }
	                			
	                onMessageReceived: {
	                    console.log("Message received: " + message.data)   
	                }
	                
	                function reloadWebView() {
	                    sendWebViewMessage() 
	                }
	            }   
			  
			     Container {
			         layout: DockLayout {}
			         Container {
			             topPadding: 2
				         ListView {
				             id: periodListView
				             objectName: "periodListView"
				             dataModel: GroupDataModel {
				                     id: reportModel
				                     objectName: "reportModel"
				                     sortingKeys: [ "isMain","yearRank", "monthRank", "dayRank"]
				                     sortedAscending: false

				                     onItemAdded: {
				                         console.log("onItemAdded signal ran.")
				                         var reportItem = data(indexPath);
				                         console.log("reportItem.name: " + reportItem.budgetType);
				                         //var indexP = (indexPath.length == 1) ? indexPath : indexPath[1]
				                         console.log("size: " + size());
				                         //Clear graphDataArray when ListView reloads. (Ex: Setting different account)
				                         if (size() == 1) 
				                             graphDataArray = ""
				                         if(size() > 0 && size() < 7) {
				                             console.log("Attempting to add to array")
				                             var qGraphMap = {}
				                             var amountSaved = parseFloat(reportItem.budgetAmount) - parseFloat(reportItem.budgetUsed)
				                             var endDate = smallDate(reportItem.endDate)
				                             qGraphMap['months'] = endDate
				                             qGraphMap['value'] = amountSaved
				                             console.log("*qGraphMap.months: " + qGraphMap['months'])
				                             console.log("*qGraphMap.value: " + qGraphMap['value'])
				                             periodListView.pushGraphDataArray(qGraphMap)
				                         }
				                         //Capping the number of periods tracked to 50, performance purpose
				                         //When the settings page is added, have an option to change this
				                         if (size() > 2) {
				                             console.log("Size is greater than 50, removing oldest period.");
				                             var removablePeriod = data(last());
                                             //removeAt(last());
				                             budgetApp.removeExcessPeriod(removablePeriod);
                                             //Send command here to C++ to delete removablePeriod from json files
				                         }
				                     }
				                 }
				             listItemComponents: [
				                 ListItemComponent {
				                     type: "header"
				                 },
				                 ListItemComponent {
				                     type: "item"
				                     Container {
				                         id: reportItemContainer
				                         ReportItem {
				                             id: reportItem 
				                         }
				                         Divider {
				                             topMargin: 0
				                             bottomMargin: 0
				                         }
				                     }
				                 }
				             ]
				             attachedObjects: [
				                 ComponentDefinition {
				                     id: periodPageDefinition
				                     source: "PeriodPage.qml"  
				                 }
				             ]
				             onTriggered: {
				                 selectedPeriod = dataModel.data(indexPath)
				                 periodPage = periodPageDefinition.createObject()
				                 Application.menuEnabled = false
				                 console.log("dataArray before heading out: " + JSON.stringify(dataArray))
					             periodPage.setArrayValue(dataArray)
					             if (!dataArray) {
					                 periodPage.showInfoToast()
					             }
					             reportsPage.push(periodPage)
				             }
				             
				             function setPieDataArray(val) {
				                 //console.log("Setting dataArray()..: " + JSON.stringify(val))
				                 dataArray = val   
				             }
				             
				             function pushGraphDataArray(val) {
					             //Convert the string, graphDataArray, to Json object. Push on map. Reconvert and save graphDataArray as string.
					             var tempJson = []
					             var arrayLength = 0
					             if (graphDataArray != "") {
					                 tempJson = JSON.parse(graphDataArray)
					                 arrayLength = tempJson.length
					             }
					             //Make sure you don't add more than 6
					             if (arrayLength < 6) {
						             tempJson.push(val)
						             graphDataArray = JSON.stringify(tempJson)
						             console.log("From pushGraphDataArray(): " + graphDataArray)
						         }
				             }
				         }
				     }
			         ImageView {
			             imageSource: "asset:///images/borderthin2.png"
			         }  
			         
			         onCreationCompleted: {
			             console.log("Creation of listview in reports page completed")
			         }
			     }
		   }
		   //Advertisement
		   Container {
		       horizontalAlignment: HorizontalAlignment.Center
		       verticalAlignment: VerticalAlignment.Bottom
		       
		       Banner {
		           zoneId: 117145
		           preferredWidth: 300
		           preferredHeight: 50
		           horizontalAlignment: HorizontalAlignment.Center
		       }
		       
		   }
	   }
   }
   
   function updateGraph(updatedMap) {
       console.log("About to update graph in javascript")
       console.log("updatedMap: " + updatedMap)
       console.log("updatedMap.budgetAmount: " + updatedMap.budgetAmount)
       //Get newest period and resend data to graph
       sendWebViewUpdate(updatedMap)
   }
    function pushSettingPage() {
        if (reportsPage.top == accountPage) {
            reportsPage.pop()
        }
        if (reportsPage.top != settingsPage) {
            settingsPage = settingsPageDefinition.createObject()
            reportsPage.push(settingsPage)
        }
    }
    function pushAccountPage() {
        if (reportsPage.top == settingsPage) {
            reportsPage.pop()
        }
        if (reportsPage.top != accountPage) {
            accountPage = accountPageDefinition.createObject()
            reportsPage.push(accountPage)
            budgetApp.setUpAccountListModel()
            accountPage.popAccountPage.connect(switchToList)
        }
    }
    function sendWebViewMessage() {
        console.log("Sending out msg: " + "initial***" + graphDataArray)
        webView.postMessage("initial***" + graphDataArray)   
    }
    
    function sendWebViewUpdate(updatedMap) {
        console.log("Sending out msg: " + "update***" + updatedMap)
        webView.postMessage("update***" + updatedMap.budgetAmount + "^" + updatedMap.budgetUsed + "^" + smallDate(updatedMap.endDate))
    }
    
    function smallDate(date) {
        console.log("smallDate: " + date);
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
        return splitDate[0] + " " + splitDate[1]
    }
    
    attachedObjects: [
        ComponentDefinition {
            id: accountPageDefinition
            source: "AccountPage.qml"   
        },
        ComponentDefinition {
            id: settingsPageDefinition
            source: "Settings.qml"   
        }
    ]
    
   //Destroys the page that was pushed on selection
    onPopTransitionEnded: {
        console.log("Transitioning off")
        Application.menuEnabled = true
        if (page == periodPage) {
            console.log("Destroying Period page")
            page.destroy()
        } else if (page == periodExpensesPage) {
            console.log("Destroying Period expenses page")
            page.destroy()  
        } else if (page == settingsPage) {
            console.log("Destroying Settings page")
            page.destroy() 
        } else if (page == accountPage) {
            console.log("Destroying Accounts page")
            page.destroy()
        }
    }
}