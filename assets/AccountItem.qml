import bb.cascades 1.0
import bb.system 1.0

	Container {
	    layout: StackLayout { orientation: LayoutOrientation.LeftToRight }
	    topPadding: 6
	    bottomPadding: 10
	    leftPadding: 15
	    rightPadding: 15
	    background: accountItemComp.ListItem.indexInSection == 0 ? Color.create("#dcecf6") : Color.White
	    
	    property string accountName : ListItemData.accountName
	    property string budgetType : accountItemComp.ListItem.view.getBudgetType(ListItemData.accountID)
	    property string budgetAmount : accountItemComp.ListItem.view.getBudgetAmount(ListItemData.accountID)
	    property string budgetUsed : accountItemComp.ListItem.view.getBudgetUsed(ListItemData.accountID)
	    
	    Container {
	        topPadding: 30
	        verticalAlignment: VerticalAlignment.Center
		    layoutProperties: StackLayoutProperties { spaceQuota: 1.2 }
		    Label {
		        bottomMargin: 0
		        textStyle { 
		            fontSize: FontSize.PointValue
	    		    fontSizeValue: 9
		        }
		        text: ListItemData.accountName
		    }
		    
		    Label {
		        topMargin: 0
		        horizontalAlignment: HorizontalAlignment.Left
		        textStyle { 
		            fontSize: FontSize.PointValue
		            fontSizeValue: 5.5
		        }
		        text: accountItemComp.ListItem.indexInSection == 0 ? "Primary Account" : ""
		    }
		}
	    Container {
	        verticalAlignment: VerticalAlignment.Center
	        horizontalAlignment: HorizontalAlignment.Right
	        layoutProperties: StackLayoutProperties { spaceQuota: 1 }
	        layout: StackLayout {}
	        
	        Container {
	            horizontalAlignment: HorizontalAlignment.Right
		        Label {
		            textStyle {
		                fontSize: FontSize.Medium
		            }
		            text: budgetType.charAt(0).toUpperCase() + budgetType.slice(1)
		        }
		    }
	        
	        Container {
	            verticalAlignment: VerticalAlignment.Center
	            horizontalAlignment: HorizontalAlignment.Right
	            layout: StackLayout { orientation: LayoutOrientation.LeftToRight }
	            Container {
				    Label {
				        horizontalAlignment: HorizontalAlignment.Right
				        bottomMargin: 0
				        text: (parseFloat(budgetAmount) - parseFloat(budgetUsed))%1 === 0 ? "$" + addComma((parseFloat(budgetAmount) - parseFloat(budgetUsed)).toString()) : "$" + addComma((parseFloat(budgetAmount) - parseFloat(budgetUsed)).toFixed(2).toString())
				    
				        textStyle { 
				            fontSize: FontSize.Medium
				            color: (parseFloat(budgetUsed)/parseFloat(budgetAmount))*100 < 60 ? Color.create("#009621") : ((parseFloat(budgetUsed)/parseFloat(budgetAmount))*100 < 90 ? Color.create("#9d5d02") : Color.create("#960000"))
				        }
				    }
				    
				    Label { 
				        topMargin: 0
				        horizontalAlignment: HorizontalAlignment.Right
				        textStyle {
				            fontSize: FontSize.PointValue
				            fontSizeValue: 5.5
				        }
				        text: "Remaining"
				    }
				}
			    Container {
			        leftPadding: 10
			        layout: StackLayout {}
				    Label {
				        horizontalAlignment: HorizontalAlignment.Right
				        bottomMargin: 0
				        textStyle {
				            fontSize: FontSize.Medium
				        }
				        text: parseFloat(budgetAmount)%1 === 0 ? "$" + addComma(parseFloat(budgetAmount).toString()) : "$" + addComma(parseFloat(budgetAmount).toFixed(2).toString())
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
		
		contextActions: [
		    ActionSet {
		        title: "Account Actions"
		        
		        actions: [
		            ActionItem {
		                title: "Edit title"
		                imageSource: "asset:///images/ic_rename.png"
		            
			            attachedObjects: [
			                SystemToast {
			                    id: renameToast
			                    body: "Changed account title!"
			                },
			                SystemPrompt {
			                    id: renameDialog
			                    title: "Edit title"
			                    body: "Enter new account title"
			                    onFinished: {
			                        if (renameDialog.result == SystemUiResult.ConfirmButtonSelection) {
			                            accountItemComp.ListItem.view.callChangeAccountName(ListItemData.accountID, renameDialog.inputFieldTextEntry())
			                            renameToast.show()
			                        }
			                    }
			                }
			            ]
			            
			            onTriggered: {
			                renameDialog.show()   
			            }
		            },
		            ActionItem {
		                title: "Delete account"
		                imageSource: "asset:///images/ic_delete.png"
		                
		                attachedObjects: [
			                SystemToast {
			                    id: deleteToast
			                    body: "Deleted account!"			                    
			                },
			                SystemDialog {
			                    id: deleteDialog
			                    title: "Delete account"
			                    body: "Are you sure you want to delete this account and its expenses?"
			                    onFinished: {
			                        if (deleteDialog.result == SystemUiResult.ConfirmButtonSelection) {
			                            if (accountItemComp.ListItem.sectionSize > 1) {
				                            accountItemComp.ListItem.view.callDeleteAccount(ListItemData.accountID,accountItemComp.ListItem.indexInSection)
				                            deleteToast.show()
				                        }
			                        }
			                    }
			                }
			            ]
			            onTriggered: {
			                deleteDialog.show()   
			            }
		            }
		        ]
		    }
		]
		
		function addComma(amount) {
		    var amountArray = amount.toString().split(".");
		    return amountArray[0].replace(/\B(?=(\d{3})+(?!\d))/g, ",") + (amountArray[1] ? "." + amountArray[1] : "");
		}
		
	}
