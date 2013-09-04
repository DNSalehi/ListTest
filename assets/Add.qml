import bb.cascades 1.0
NavigationPane {
    id: addPage
    objectName: "addPageNav"
    property variant setDate
    property variant accountPage
    property variant settingsPage
    property string expenseName: expenseNameField.text
    property string titleName: "addPage"
    property bool downKeyboardBool: false
    
    Page {
        id: addPageChild
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
    		            id: amountLabel
    		            objectName: "amountLabel"
    		            verticalAlignment: VerticalAlignment.Fill
    		            textStyle { 
    		            	fontSize: FontSize.PointValue
    		            	fontSizeValue: 23
    		            	color: Color.White
    		            }
    		            text: "$0.00"
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
	            	    
	            	    onCreationCompleted: {
	            	        var theDate = new Date()
	            	    }
	            	}
            	    
            	    TextField {
            	        id: expenseNameField
            	        hintText: "Expense Name"
            	    }
            	    
            	    EasyKeyboard {
            	        id: easyKeyboard
            	        topMargin: 30
            	        horizontalAlignment: HorizontalAlignment.Center
            	    }
            	}
         }
     }
}

function pushSettingPage() {
    
    if (addPage.top == accountPage) {
        addPage.pop()
    }
    if (addPage.top != settingsPage) {
        settingsPage = settingsPageDefinition.createObject()
        addPage.push(settingsPage)
    }
}

 function pushAccountPage() {
     if (addPage.top == settingsPage) {
         addPage.pop()
     }
     if (addPage.top != accountPage) {
         accountPage = accountPageDefinition.createObject()
         addPage.push(accountPage)
         budgetApp.setUpAccountListModel()
         accountPage.popAccountPage.connect(switchToList)
     }
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
     if (page == settingsPage) {
         console.log("Destroying Settings page")
         page.destroy() 
     } else if (page == accountPage) {
         console.log("Destroying Accounts page")
         page.destroy()
     }
 }

   function getPageName() {
       return titleName   
   }
 
  function clearAdd() {
      budgetApp.clearAmountText()
      setDate = new Date()
      dropDown.setSelectedIndex(0)
      expenseNameField.text = ""
      datePicker.value = Qt.formatDateTime(setDate,'yyyy-MM-dd')
  }
}