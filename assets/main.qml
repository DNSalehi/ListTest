import bb.cascades 1.0

TabbedPane {
    id: mainTab
    showTabsOnActionBar: true
    
    Tab {
        id: expenseTab
        title: "Expenses"
        imageSource: "asset:///images/ic_view_details.png"
        
        Transactions {
            id: expensePage
        }
        onTriggered: addPage.clearAdd()
        
    }
    
    Tab {
        id: addTab
        title: "Add"
        imageSource: "asset:///images/ic_add.png"
        
        Add {
          id: addPage
        }
        
        onTriggered: {
            addPage.clearAdd()
        }
    }
    
    Tab {
        id: reportTab
        title: "Reports"
        imageSource: "asset:///images/reportsIcon.png"
        
        Reports {
            id: reportsPage
        }
    }

    Menu.definition: MenuDefinition {
        /*
        //For settings, put it back when you implement a settings page
        settingsAction: SettingsActionItem {
            onTriggered : {
                if (mainTab.activeTab == expenseTab) {
	               expensePage.pushSettingPage()
	               console.log("Called expensePage push settings");
	           } else if (mainTab.activeTab == addTab) {
	               addPage.pushSettingPage()
	               console.log("Called addPage push settings");
	           } else if (mainTab.activeTab == reportTab) {
	               reportsPage.pushSettingPage()
	               console.log("Called reportsPage push settings");
	           }
	        }
        }
        */
        actions: [
          ActionItem {
              imageSource: "asset:///images/ic_lock.png"
              title: "Lock"
              attachedObjects: [
                  LockSheet {
                      id: lockSheet
                  }
              ]
              onTriggered: {
                  if (budgetApp.hasPin()) {
                      lockSheet.enableLock()
                  } else {
                      lockSheet.open()
                  }
              }
          },
          ActionItem {
              imageSource: "asset:///images/ic_info.png"
              title: "Info"
              
              onTriggered : {
                  if (mainTab.activeTab == expenseTab) {
                      expensePage.pushSettingPage()
                      console.log("Called expensePage push settings");
                  } else if (mainTab.activeTab == addTab) {
                      addPage.pushSettingPage()
                      console.log("Called addPage push settings");
                  } else if (mainTab.activeTab == reportTab) {
                      reportsPage.pushSettingPage()
                      console.log("Called reportsPage push settings");
                  }
              }
          }, 
          ActionItem {
              imageSource: "asset:///images/ic_add_to_contacts.png"
              title: "Switch account"
              
              onTriggered : {
                  if (mainTab.activeTab == expenseTab) {
                      expensePage.pushAccountPage()
                      console.log("Called expensePage push account");
                  } else if (mainTab.activeTab == addTab) {
                      addPage.pushAccountPage()
                      console.log("Called addPage push account");
                  } else if (mainTab.activeTab == reportTab) {
                      reportsPage.pushAccountPage()
                      console.log("Called reportsPage push account");
                  }
              }
          }
        ]
       }
    
    function switchToList() {
        console.log("Switching to main tab.")
        mainTab.activeTab = expenseTab
    }
    
    onCreationCompleted: {
        console.log("Creation completed");
    }
}
