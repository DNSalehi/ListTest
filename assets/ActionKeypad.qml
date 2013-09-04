import bb.cascades 1.0

Container {
    layout: DockLayout {}
    property alias text: label.text
    property alias image: imagev.imageSource
    property alias actionImage: actionImage.imageSource
    property variant actionNum

    ImageView {
        id: imagev
        horizontalAlignment: HorizontalAlignment.Center
        verticalAlignment: VerticalAlignment.Center
        rightMargin: 0
        leftMargin: 0
        imageSource: "asset:///images/blackBtn.png"
    }
    
    Label {
        id: label
        horizontalAlignment: HorizontalAlignment.Center
        verticalAlignment: VerticalAlignment.Center
        textStyle {
            fontSize: FontSize.XLarge
            color: Color.White
        }
        text: "Unlock"            
    }
    
    ImageView { 
        id: actionImage
        horizontalAlignment: HorizontalAlignment.Center
        verticalAlignment: VerticalAlignment.Center
    }
    
    gestureHandlers: [
        TapHandler {
             onTapped: {
                 if (label.text == "") {
                     if (titleName == "createLock") {
                         createLabel.text = (createLabel.text).substring(0, (createLabel.text).length - 1);
                     } else if (titleName == "verifyLock") {
                         verifyLabel.text = (verifyLabel.text).substring(0, (verifyLabel.text).length - 1);
                     }
                 } else {
                     if (label.text == "Unlock") {
                         //Verify c++ function, if true..
                         if (budgetApp.verifyPin(verifyLabel.text)) {
                             console.log("Pin verified")
                             if (isLockPage()) {
                                 console.log("isLockPage")
                                 budgetApp.lockApp("false")
                                 console.log("set to false")
                                 verifyLabel.text = ""
                                 console.log("text blanked")
                                 if (budgetApp.loadQMLScene()) console.log("loaded **");
                                 console.log("loaded le page")
                             } else {
                                 console.log("is NOT lock page")
		                         budgetApp.lockApp("false")
                                 console.log("set to false")
		                         verifyLabel.text = ""
                                 console.log("text blanked")
		                         close()
			                     switchToList()
			                 }
		                 } else {
		                     //if false...
		                     shakeLock()
		                     verifyLabel.text = ""
		                 }
	                     
	                 } else if (label.text == "Save") {
	                     //Create lock c++ function
	                     budgetApp.createPin();
                         //Clear out verifyPage's amountText and label
                         createLabel.text = ""
                         //Switch to verifyPage
                         enableLock()
                         close()
	                 }
                 }
             }               
        }
    ]
}