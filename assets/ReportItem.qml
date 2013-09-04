import bb.cascades 1.0

Container {
	    layout: StackLayout { orientation: LayoutOrientation.LeftToRight }
	    topPadding: 14
	    bottomPadding: 13
	    leftPadding: 15
	    rightPadding: 15
	    background: reportItemContainer.ListItem.indexInSection % 2 ? Color.White : Color.create("#ececec")
	    
	    Container {
	        topPadding: 0
	        bottomPadding: 0
	        verticalAlignment: VerticalAlignment.Center
		    layoutProperties: StackLayoutProperties { spaceQuota: 1.2 }
		    layout: StackLayout {}
		    
		    Label {
		        topMargin:0
		        bottomMargin: 0
		        textStyle {
		            fontSize: FontSize.Medium
				}
		        text: miniDate(ListItemData.endDate)
		    }
		    Label {
		        topMargin: 0
		        bottomMargin: 0
		        textStyle {
		            fontSize: FontSize.Medium
		        }
		        text: miniDate(ListItemData.startDate)
		    }
		}
	    Container {
	        verticalAlignment: VerticalAlignment.Center
	        horizontalAlignment: HorizontalAlignment.Right
	        layoutProperties: StackLayoutProperties { spaceQuota: 1 }
	        layout: StackLayout {}
	        
	        Container {
	            verticalAlignment: VerticalAlignment.Center
	            horizontalAlignment: HorizontalAlignment.Right
	            layout: StackLayout { orientation: LayoutOrientation.LeftToRight }
	            Container {
				    Label {
				        horizontalAlignment: HorizontalAlignment.Right
				        verticalAlignment: VerticalAlignment.Center
				        bottomMargin: 0
				        textStyle { 
				            fontSize: FontSize.Medium
				            color: (parseFloat(ListItemData.budgetUsed)/parseFloat(ListItemData.budgetAmount))*100 > 100 ? Color.create("#960000") :Color.create("#009621")
				        }
				        text: (parseFloat(ListItemData.budgetAmount) - parseFloat(ListItemData.budgetUsed))%1 === 0 ? "$" + addComma(parseFloat(ListItemData.budgetAmount) - parseFloat(ListItemData.budgetUsed)) : "$" + addComma((parseFloat(ListItemData.budgetAmount) - parseFloat(ListItemData.budgetUsed)).toFixed(2))
				    }
				    
				    Label { 
				        topMargin: 0
				        horizontalAlignment: HorizontalAlignment.Right
				        textStyle {
				            fontSize: FontSize.PointValue
				            fontSizeValue: 5.5
				        }
				        text: "Savings"
				    }
				}
			    Container {
			        leftPadding: 10
			        layout: StackLayout {}
				    Label {
				        horizontalAlignment: HorizontalAlignment.Right
				        verticalAlignment: VerticalAlignment.Center
				        bottomMargin: 0
				        textStyle {
				            fontSize: FontSize.Medium
				        }
				        text: parseFloat(ListItemData.budgetAmount)%1 === 0 ? "$" + addComma(parseFloat(ListItemData.budgetAmount)) : "$" + addComma(parseFloat(ListItemData.budgetAmount).toFixed(2))
				    }
				    
				    Label { 
				        topMargin: 0
				        horizontalAlignment: HorizontalAlignment.Right
				        textStyle {
				            fontSize: FontSize.PointValue
				            fontSizeValue: 5.5
				        }
				        text: "Total Budget"
				    }
				}
			}
		}
		
		function addComma(amount) {
		    var amountArray = amount.toString().split(".");
		    return amountArray[0].replace(/\B(?=(\d{3})+(?!\d))/g, ",") + (amountArray[1] ? "." + amountArray[1] : "");
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
		/*
		onCreationCompleted: {
		    //Send top 6 reportItems for points on the line graph
		    if (reportItemContainer.ListItem.indexInSection < 6) {
			    console.log("ReportItem created")
			    console.log("indexInSection: " + reportItemContainer.ListItem.indexInSection)
			    var tempGraph = []
			    var qGraphMap = {}
			    var amountSaved = parseFloat(ListItemData.budgetAmount) - parseFloat(ListItemData.budgetUsed)
			    var startDate = ListItemData.endDate
			    var shortDateArray = miniDate(startDate).split(" ")
			    var shortDate = shortDateArray[0] + " " + shortDateArray[1]
			    console.log("shortDate: " + shortDate)
			    console.log("amountSaved: " + amountSaved)
			    
			    qGraphMap['months'] = shortDate;
			    qGraphMap['value'] = amountSaved;
			    reportItemContainer.ListItem.view.pushGraphDataArray(qGraphMap)
			    if (reportItemContainer.ListItem.indexInSection == reportItemContainer.ListItem.sectionSize-1) {
			        //Less that 6 items, reached the end
			        reportItemContainer.ListItem.view.pushGraphDataArray("Finished")
			    }
			} else if (reportItemContainer.ListItem.indexInSection == 6) {
			    //Send message that the last reportItem has been sent
			    reportItemContainer.ListItem.view.pushGraphDataArray("Finished")
			}
		}
		*/
		
		onControlAdded: {
		    console.log("Control added!")   
		}
		
		onControlReplaced: {
		    console.log("Control replaced!")   
		}
		
		onTouch: {   
		    if (event.isDown()) {
			    console.log("Fill pie page")
			    var tempData = []
			    var qMap = {}
			    var intGeneral = 0
			    var intRestaurant = 0
			    var intGroceries = 0
			    var intGas = 0
			    var intEntertainment = 0
			    var intClothing = 0
			    var intSchool = 0
			    var intMedical = 0
			    var intHousing = 0
			    
			    var valArray = [intGeneral,intRestaurant,intGroceries,intGas,intEntertainment,intClothing,intSchool,intMedical,intHousing]
			    var categoryArray = ["General","Restaurant","Groceries","Gas","Entertainment","Clothing","School","Medical","Housing"]
                var iconArray = ["general","resteraunt","groceries","gas","entertainment","clothing","school","medical","housing"]
			    
			    if (ListItemData.expenses) {
			        console.log("OG Expenses: " + ListItemData.expenses)
			        var expenseList = ListItemData.expenses
			    		for (var x=0;x<expenseList.length;x++) {
			    		    for (var y=0;y<iconArray.length;y++) {
			    		        if (expenseList[x].icon == iconArray[y]) {
			    		            //Increment value
			    		            valArray[y]++;
			    		            //Clear qMap
			    		            qMap = {}
			    		            //If there is no other instance of the category, create a qMap of it and push it onto the JSON Object
			    		            if (valArray[y] == 1) {
			    		                console.log("Adding new category, " + categoryArray[y])
			    		                qMap['category'] = categoryArray[y]
			    		                qMap['value'] = expenseList[x].amount
			    		                console.log("New value: " + qMap['value'])
			    		                tempData.push(qMap)
			    		            } else {
			    		                console.log("Category, " + categoryArray[y] + ", exists already. valArray[y]: " + valArray[y])
			    		                //Since category already exists, find it in JSON object and update the value to new the incremented value
			    		                for (var z=0;z<tempData.length;z++) {
			    		                    if (tempData[z].category == categoryArray[y]) {
			    		                        tempData[z].value = parseFloat(tempData[z].value) + parseFloat(expenseList[x].amount)
			    		                        console.log("Summed value: " + tempData[z].value)
			    		                    }   
			    		                }
			    		            }
			    		        }
			    		    }
			    		}
				   		reportItemContainer.ListItem.view.setPieDataArray(tempData)
				   		console.log("Final length of categoryArray: " + tempData.length)
				 } else {
				     console.log("There are no expenses for this period")   
				     reportItemContainer.ListItem.view.setPieDataArray(null)
				 }
		    }
		}
}