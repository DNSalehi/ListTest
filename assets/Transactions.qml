// Default empty project template
import bb.cascades 1.0
import bb.data 1.0
import bb.cascades.advertisement 1.0

NavigationPane {
    id: nav
    property variant settingsPage
    property variant accountPage
    property variant contentView
    property variant editPage
    property variant selectedIndex
    property variant selectedItem
    
    Page {
        id: expenseListPage
        
        Container { 
            layout: DockLayout {}
            bottomPadding: 0
            
	        Container {
	            layout: StackLayout {}

	            Container {
	                layout: DockLayout {}
	                horizontalAlignment: HorizontalAlignment.Center
	                bottomPadding: 30
	                topPadding: 83
	                Container {
	                    layout: DockLayout {}
		                    topPadding: 5
		                    ImageView {
		                        id: barBG
		                        imageSource: "asset:///images/newbar/fullBarThin3.png"
		                    }
		                    Container {
			                    layout: AbsoluteLayout {}
			                    ImageView {
			                        id: expenseBar
			                        objectName: "expenseBar"
			                        visible: false
			                        imageSource: "asset:///images/newbar/greenerBar.png"
			                        layoutProperties: AbsoluteLayoutProperties {
			                            // -721 is minimum | -66 is max | 655 unit difference
			                            id: expenseBarLayout
			                            objectName: "expenseBarLayout"
			                            positionX: -66
			                            positionY: 11
			                        }
			                    }
			                }
		                    ImageView {
		                        id: emptyBar
		                        imageSource: "asset:///images/newbar/emptyBarThin3.png"
		                    }
	                }
	                Container {
	                    layout: AbsoluteLayout {
	                    }
	                    Label {
	                        id: createBudgetLabel
	                        objectName: "createBudgetLabel"
	                        text: qsTr("Click here to set your budget")
	                        visible: false
	                        topMargin: 10
	                        textStyle {
	                            fontSize: FontSize.Medium
	                            color: Color.Black
	                        }
	                        layoutProperties: AbsoluteLayoutProperties {
	                            id: createBudgetLabelLayout
	                            objectName: "createBudgetLabelLayout"
	                            positionX: 151
	                            positionY: 60
	                        }
	                    }
	                    ImageButton {
	                        visible: true
	                        defaultImageSource: "asset:///images/barBG.png"
	                        layoutProperties: AbsoluteLayoutProperties {
	                            positionX: 56
	                        }
	                        onClicked: {
	                            console.log("onClick event called")
	                            console.log("Sheet attempting to be opened")
	                            budgetSheet.open()
	                            console.log("Setting component values")
	                            budgetSheet.setComponentValues()
	                            budgetApp.fillBudgetPage()
	                            console.log("filled the budget Page")
	                        }
	                    }
	                }
	            }
	            Container {
	                layout: DockLayout {}
	                
	                Container {
	                    topPadding: 2
	                    ListView {
	                        id: expenseListView
	                        objectName: "expenseListView"
	                        dataModel: XmlDataModel { }
	                        listItemComponents: [
	                            ListItemComponent {
	                                type: "header"
	                            },
	                            ListItemComponent {
	                                type: "item"
	                                Container {
	                                    id: listItemComp
	                                    TransactionItem {
	                                    }
	                                    Divider {
	                                        topMargin: 0
	                                        bottomMargin: 0
	                                    }
	                                }
	                            }
	                        ]
	                        onTriggered: {
	                            //selectedIndex = indexPath;
	                            selectedItem = dataModel.data(indexPath);
	                            //select(indexPath)
	                            editPage = editPageDefinition.createObject()
	                            Application.menuEnabled = false
	                            nav.push(editPage)
	                            budgetApp.editAmountText(selectedItem.amount)
	                        }
	                        attachedObjects: [
	                                                    GroupDataModel {
	                                                        id: expenseModel
	                                                        sortingKeys: [
	                                                            "yearRank",
	                                                            "monthRank",
	                                                            "dayRank",
	                                                            "hourRank",
	                                                            "minuteRank",
	                                                            "secondRank"
	                                                        ]
	                                                        onItemAdded: {
	                                                            console.log("Successfully added item.")
	                                                        }
	                                                        onItemRemoved: {
	                                                            var lastIndexPath = last()
	                                                            if (lastIndexPath[0] == undefined) {
	                                                                if (nav.top != expenseListPage) nav.popAndDelete()
	                                                            }
	                                                        }
	                                                    }
	                                                ]
	                    }
                    }
                    
                    ImageView {
	                    imageSource: "asset:///images/borderthin2.png"
	                }
                }
            }
            
        Container {
            layout: StackLayout { orientation: LayoutOrientation.LeftToRight }
            topPadding: 33
            
            Container {
                layout: DockLayout {}
                layoutProperties: StackLayoutProperties { spaceQuota: 1 }
                horizontalAlignment: HorizontalAlignment.Left
                verticalAlignment: VerticalAlignment.Bottom
                Label { 
                    id: spentLabel
                    objectName: "spentLabel"
                    horizontalAlignment: HorizontalAlignment.Right
                    text: qsTr("$0.00")
                    visible: true
                    textStyle {
                        fontSize: FontSize.Large
                        color: Color.Black
                        textAlign: TextAlign.Right
                        fontWeight: FontWeight.Bold
                    }
                }
            }

            Container {
                layout: DockLayout {}
                layoutProperties: StackLayoutProperties { spaceQuota: 1.35 }
                horizontalAlignment: HorizontalAlignment.Right
                verticalAlignment: VerticalAlignment.Bottom
                leftPadding: 33
                Label { 
                    id: remainingLabel
                    objectName: "remainingLabel"
                    horizontalAlignment: HorizontalAlignment.Left
                    text: qsTr("$0.00")
                    visible: true
                    leftMargin: 35
                    textStyle {
                        fontSize: FontSize.XLarge
                        color: Color.create("#409532")
                        textAlign: TextAlign.Left
                        fontWeight: FontWeight.Bold
                    }
                }
            }
        }
        
        //Advertisement
        Container {
            topPadding: 0
            bottomPadding: 0
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
        attachedObjects: [
            ComponentDefinition {
                id: editPageDefinition
                source: "EditPage.qml"
            },
            BudgetSheet {
                id: budgetSheet
                objectName: "budgetSheet"
            }
        ]
    }

    //Pushing pages from main.qml for the top menu
    function pushSettingPage() {
        if (nav.top == accountPage) {
            nav.pop()
        }
        if (nav.top != settingsPage) {
            settingsPage = settingsPageDefinition.createObject()
            nav.push(settingsPage)
        }
    }
    
    function pushAccountPage() {
        if (nav.top == settingsPage) {
            nav.pop()
        }
        if (nav.top != accountPage) {
            accountPage = accountPageDefinition.createObject()
            nav.push(accountPage)
            budgetApp.setUpAccountListModel()
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
    //Clears selection when backing out from a selected item
    onTopChanged: {
        if (page == expenseListPage) 
            expenseListView.clearSelection()
    }
    //Destroys the page that was pushed on selection
    onPopTransitionEnded: {
        Application.menuEnabled = true
        if (page == editPage) {
            console.log("Destroying Edit Expense page")
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
