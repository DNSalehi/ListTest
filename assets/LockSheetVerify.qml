import bb.cascades 1.0

Sheet {
    id: lockSheetVerify
    objectName: "lockSheetVerify"
    peekEnabled: false
    property string titleName: "verifyLock"
    
    Page {
        id: verifyLock
        objectName: "lockSheetPage"
        
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
    		            id: verifyLabel
    		            objectName: "verifyLabel"
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
    	    ImageView {
    	        id: lockImg
    	        horizontalAlignment: HorizontalAlignment.Center
    	        imageSource: "asset:///images/lockBig.png"
    	        animations: [
    	            SequentialAnimation {
    	                id: shakeAnim
    	                TranslateTransition {
    	                    fromX: 0
    	                    toX: 12
    	                    duration: 50
    	                }
    	                TranslateTransition {
    	                    fromX: 12
    	                    toX: -12
    	                    duration: 50
    	                }
    	                TranslateTransition {
    	                    fromX: -12
    	                    toX: 12
    	                    duration: 50
    	                }
    	                TranslateTransition {
    	                    fromX: 12
    	                    toX: 0
    	                    duration: 50
    	                }
    	            }
    	        ]
    	    }
    	    
    	    Label {
    	        horizontalAlignment: HorizontalAlignment.Center
    	        topMargin: 15
    	        text: qsTr("Enter pin number")
    	        textStyle { 
    	            fontSize: FontSize.XXLarge
    	            fontWeight: FontWeight.Bold
    	        }
    	    }
        
        EasyKeypad {
            id: easyKeypad
            topMargin: 60
            horizontalAlignment: HorizontalAlignment.Center
        }
    }
	}
	function getPageName() {
	    console.log("Page is getting set as: " + titleName)
		return titleName
    }
    
    function shakeLock() {
        console.log("SHAKE THE LOCK!!")
       shakeAnim.play()
    }
    
    function isLockPage() {
        return false   
    }
	onOpened: {
	    verifyLabel.text = ""
	    budgetApp.lockApp("true")
	}
}