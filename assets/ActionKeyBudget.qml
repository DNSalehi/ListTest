import bb.cascades 1.0

Container {
    layout: DockLayout {}
    property alias text: label.text
    property alias image: imagev.imageSource
    property alias actionImage: actionImage.imageSource

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
        text: "Done"            
    }
    
    ImageView { 
        id: actionImage
        horizontalAlignment: HorizontalAlignment.Center
        verticalAlignment: VerticalAlignment.Center
    }
    
    gestureHandlers: [
        TapHandler {
             onTapped: {
                 var pageName = getPageName()
                 if (label.text != "Done") {
                     if (pageName == "budgetPage") {
                         console.log("About to call the delete digit function");
                         budgetField.text = budgetApp.deleteDigitFromValue(budgetField.text);
                         console.log("Finished calling");
                     } else if (pageName == "createAccountPage") {
                         budgetField.text = budgetApp.deleteDigitFromValue(budgetField.text);   
                     }
                 } else {
                     //Clicked on done, run function to move keyboard down out of view and remove it
                     closeKeyboard()
                     containerDown()
                     openedKeyboardBool = false
                 }
             }                
        }
    ]
}