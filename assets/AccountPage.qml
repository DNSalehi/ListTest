import bb.cascades 1.0
import bb.data 1.0
import bb.system 1.0
import bb.cascades.advertisement 1.0

Page {
    id: accountPage
    objectName: "accountPage"
    property variant selectedIndex
    property variant selectedItem
    signal popAccountPage()
    
    titleBar: TitleBar {
        title : "Accounts"
    }
    
    Container {
        layout: DockLayout {}
        
            ListView {
                id: accountListView
                objectName: "accountListView"
                dataModel: XmlDataModel { }
                
                listItemComponents: [
                    ListItemComponent {
                        type: "header"
                        Header {
                            title: ListItemData.accountName
                        }
                    },
                    ListItemComponent {
                        type: "item"
                        Container {   
                            id: accountItemComp
                            AccountItem { 
                                id: accountItem
                            }
                            Divider {
                                topMargin: 0
                                bottomMargin: 0
                            }
                        }
                    }
                ]
                
                onTriggered: {
                    selectedIndex = indexPath
                    selectedItem = dataModel.data(indexPath)
                    budgetApp.setAccount(selectedItem)
                    accountPage.parent.pop()
                    popAccountPage()
                }
                attachedObjects: [
                    GroupDataModel {
                        id: accountModel
                        sortingKeys: ["isMain","accountID","accountName","accountBudget"]
                        onItemAdded: {  console.log("Successfully added account.") }
                    }
                ]
                function callChangeAccountName(id, newName) {
                    budgetApp.changeAccountName(id, newName)   
                }
                function callDeleteAccount(id, prevIndex) {
                    console.log("Calling delete account from QML")
                    budgetApp.deleteAccount(id, prevIndex)   
                }
                function getBudgetType(id) {
                    return budgetApp.getBudgetType(id)
                }
                function getBudgetAmount(id) {
                    return budgetApp.getCurrentBudget(id)
                }
                function getBudgetUsed(id) {
                    return budgetApp.getUsedBudget(id)
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
    actions: [
    	ActionItem {
    	    id: addAccount
    	    title: "Add"
    	    imageSource: "asset:///images/ic_add.png"
    	    ActionBar.placement: ActionBarPlacement.OnBar
    	    onTriggered: {
    	        accountCreationSheet.open()
    	        accountCreationSheet.clearAll()
    	    }
    	}
    ]
    attachedObjects: [
         AccountCreationSheet {
             id: accountCreationSheet
             objectName: "accountCreationSheet"
         }
    ]
}