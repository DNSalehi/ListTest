import bb.cascades 1.0

Sheet {
    id: lockSheet
    peekEnabled: true
    property string titleName: "createLock"
    
    Page {
        id: createLock
        
        Container {
            layout: StackLayout {}
            layoutProperties: StackLayoutProperties { spaceQuota: 1 }
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
    		            id: createLabel
    		            objectName: "createLabel"
    		            verticalAlignment: VerticalAlignment.Fill
    		            textStyle { 
    		            	fontSize: FontSize.PointValue
    		            	fontSizeValue: 23
    		            	color: Color.White
    		            }
    		            text: ""
    		        }
    		    }
    	    }
    	    
    	    Label {
    	        horizontalAlignment: HorizontalAlignment.Center
    	        topMargin: 80
    	        bottomMargin: 30
    	        text: qsTr("Create a pin number")
    	        textStyle { 
    	            fontSize: FontSize.XXLarge
    	            fontWeight: FontWeight.Bold
    	        }
    	    }
        
        EasyKeypad {
            id: easyKeypad
            topMargin: 188
            horizontalAlignment: HorizontalAlignment.Center
        }
    }
    actions: [
            ActionItem {
                title: "  Back"
                imageSource: "asset:///images/ic_previoussmall.png"
                ActionBar.placement: ActionBarPlacement.OnBar
                onTriggered: {
                   close()
                }
            }
        ]
    attachedObjects: [
        LockSheetVerify {
            id: lockSheetVerify
        }
    ]
    
	}
	function getPageName() {
		return titleName
    }
    
    function enableLock() {
        console.log("Locking..")
        lockSheetVerify.open()
        console.log("Locked")
    }
    onOpened: {
        budgetApp.getCreateLabel()
        createLabel.text = ""
    }
}