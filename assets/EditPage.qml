import bb.cascades 1.0
import bb.system 1.0

Page {
    id: editPage
    signal addPageClose()
    property string titleName: "editPage"
    
    
   Container {
            layout: StackLayout {}
            Container {
                layout: DockLayout {}
    	        ImageView {
    	            imageSource: "asset:///images/topBar.png"   
    	            preferredHeight: 203
    	        }
    	        Container {
    	            horizontalAlignment: HorizontalAlignment.Center
    	            topPadding: 17
    		        Label {
    		            id: amountLabelEdit
    		            objectName: "amountLabelEdit"
    		            verticalAlignment: VerticalAlignment.Fill
    		            textStyle { 
    		            	fontSize: FontSize.PointValue
    		            	fontSizeValue: 23
    		            	color: Color.White
    		            }
    		            text: "$" + selectedItem.amount
    		        }
    		    }
    	    }
    	    
    	    ScrollView {       
    	        id: scrollView

                Container {
                    layout: StackLayout {}
                    leftPadding: 40
                    rightPadding: 40
                    horizontalAlignment: HorizontalAlignment.Center
                    verticalAlignment: VerticalAlignment.Center
                        
                    DropDown {
                        id: dropDown
                        title: "Category"
                        enabled: true
                         
                        onSelectedIndexChanged: {
                            console.log("SelectedIndex was changed to " + selectedIndex)
                        }
                        Option {
                            imageSource: "asset:///images/tabicons/general.png"
                            text: "General"
                            value: "general"
                            selected: (selectedItem.icon == "general") ?  true : false
                         
                            onSelectedChanged: {
                                if (selected == true) {
                                    console.log("General selected.")
                                }
                            }
                        }
                        
                        Option {
                            imageSource: "asset:///images/tabicons/resteraunt.png"
                            text: "Restaurant"
                            value: "resteraunt"
                            selected: (selectedItem.icon == "resteraunt") ?  true : false
                         
                            onSelectedChanged: {
                                if (selected == true) {
                                    console.log("Restaurant selected.")
                                }
                            }
                        }
                        
                        Option {
                            imageSource: "asset:///images/tabicons/groceries.png"
                            text: "Groceries"
                            value: "groceries"
                            selected: (selectedItem.icon == "groceries") ?  true : false
                         
                            onSelectedChanged: {
                                if (selected == true) {
                                    console.log("Groceries selected.")
                                }
                            }
                        }
                        
                        Option {
                            imageSource: "asset:///images/tabicons/gas.png"
                            text: "Gas"
                            value: "gas"
                            selected: (selectedItem.icon == "gas") ?  true : false
                         
                            onSelectedChanged: {
                                if (selected == true) {
                                    console.log("Gas selected.")
                                }
                            }
                        }
                        
                        Option {
                            imageSource: "asset:///images/tabicons/entertainment.png"
                            text: "Entertainment"
                            value: "entertainment"
                            selected: (selectedItem.icon == "entertainment") ?  true : false
                         
                            onSelectedChanged: {
                                if (selected == true) {
                                    console.log("Entertainment selected.")
                                }
                            }
                        }
                        
                        Option {
                            imageSource: "asset:///images/tabicons/clothing.png"
                            text: "Clothing"
                            value: "clothing"
                            selected: (selectedItem.icon == "clothing") ?  true : false
                         
                            onSelectedChanged: {
                                if (selected == true) {
                                    console.log("Clothing selected.")
                                }
                            }
                        }
                        
                        Option {
                            imageSource: "asset:///images/tabicons/school.png"
                            text: "School"
                            value: "school"
                            selected: (selectedItem.icon == "school") ?  true : false
                         
                            onSelectedChanged: {
                                if (selected == true) {
                                    console.log("School selected.")
                                }
                            }
                        }
                        
                        Option {
                            imageSource: "asset:///images/tabicons/medical.png"
                            text: "Medical"
                            value: "medical"
                            selected: (selectedItem.icon == "medical") ?  true : false
                         
                            onSelectedChanged: {
                                if (selected == true) {
                                    console.log("Medical selected.")
                                }
                            }
                        }
                        
                        Option {
                            imageSource: "asset:///images/tabicons/housing.png"
                            text: "Housing"
                            value: "housing"
                            selected: (selectedItem.icon == "housing") ?  true : false
                         
                            onSelectedChanged: {
                                if (selected == true) {
                                    console.log("Housing selected.")
                                }
                            }
                        }
                    }
                   
                    DateTimePicker {
                        id: datePicker
                        title: "Expense Date"
                        value: convertFromDate(selectedItem.dated)
                        onCreationCompleted: {
                            var theDate = new Date()
                        }
                    }
                    
            	    TextField {
            	        id: expenseNameField
            	        hintText: "Expense Name"
            	        text: selectedItem.title
            	    }
            	    
            	    EasyKeyboard {
            	        id: easyKeyboard
            	        topMargin: 30
            	        horizontalAlignment: HorizontalAlignment.Center
            	    }
            	}
         }
     }
     
     actions: [
         ActionItem {
             id: deleteAction
             title: "Delete"
             imageSource: "asset:///images/ic_delete.png"
             ActionBar.placement: ActionBarPlacement.OnBar
             
             onTriggered: {
                 removeDialog.show();
             }
             
             attachedObjects: [
                 SystemToast {
                     id: deleteToast
                     body: "Deleted Expense!"
                     
                     onPositionChanged: {
                         console.log("Position changed");
                         deleteToast.resetPosition();
                     }
                 },
                 SystemDialog {
                     id: removeDialog
                     title: "Delete expense"
                     body: "Are you sure you want to delete expense?"
                     confirmButton.label: qsTr("Delete")
                     
                     onFinished: {
                         if (result == SystemUiResult.ConfirmButtonSelection) {
                             console.log("Removing item.");
                             nav.deleteExpenseToast();
                             budgetApp.deleteItemAtIndex(selectedItem);
                             nav.pop();
                         }
                     }
                 }
             ]
         }
     ]

	function convertFromDate(prevDate) {
	    var returnString = ""
	    var monthString = ""
	    var splitString = prevDate.split(" ")
	    
	    if(splitString[0] == "January")
	        monthString = "01"
	    else if (splitString[0] == "February")
	        monthString = "02"
	    else if (splitString[0] == "March")
	    	monthString = "03"
	    else if (splitString[0] == "April")
	    	monthString = "04"
	    else if (splitString[0] == "May")
	    	monthString = "05"
	    else if (splitString[0] == "June")
	    	monthString = "06"
	    else if (splitString[0] == "July")
	    	monthString = "07"	
	    else if (splitString[0] == "August")
	    	monthString = "08"
	    else if (splitString[0] == "September")
	    	monthString = "09"
	    else if (splitString[0] == "October")
	    	monthString = "10"
	    else if (splitString[0] == "November")
	    	monthString = "11"
	    else if (splitString[0] == "December")
	    	monthString = "12"
	    	        	        	        
	    returnString += splitString[2] + "-" + monthString + "-" + splitString[1]
	    console.log("Converted date from " + prevDate + " to " + returnString)                       	        	        	        
	    return returnString
	}
	
	function getPageName() {
	    return titleName   
	}
	
  function clearAdd() {
      var theDate = new Date()
      budgetApp.clearEditAmountText()
      console.log("Date: " + theDate + " || Qt: " + Qt.formatDateTime(setDate,'yyyy-MM-dd'))
      dropDown.setSelectedIndex(0)
      expenseNameField.text = ""
      datePicker.value = Qt.formatDateTime(theDate,'yyyy-MM-dd')
  }
}