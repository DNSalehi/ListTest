import bb.cascades 1.0

Container {
    id: easyKey
    layout: DockLayout {}
    property alias text: label.text
    property alias image: imagev.imageSource

    ImageView {
        id: imagev
        horizontalAlignment: HorizontalAlignment.Center
        verticalAlignment: VerticalAlignment.Center
        rightMargin: 0
        leftMargin: 0
        imageSource: "asset:///images/grayBtn.png"
    }
    
    Label {
        id: label
        horizontalAlignment: HorizontalAlignment.Center
        verticalAlignment: VerticalAlignment.Center
        textStyle {
            fontSize: FontSize.XXLarge
            color: Color.White
        }
        text: "1"            
    }
    
    gestureHandlers: [
        TapHandler {
            id: tapHandler
             onTapped: {
                 if (titleName == "addPage") {   
                     amountLabel.text = "" + budgetApp.addDigitToValue(amountLabel.text, label.text);
                 } else if (titleName == "editPage") {
                     amountLabelEdit.text = "" + budgetApp.addDigitToValue(amountLabelEdit.text, label.text);
                 } else if (titleName == "budgetPage") {   
                     budgetField.text = budgetApp.addDigitToValue(budgetField.text, label.text);
                 } else if (titleName == "createAccountPage") {
                     budgetField.text = "" + budgetApp.addDigitToValue(budgetField.text, label.text);
                 } else if (titleName == "createLock") {
                     createLabel.text = createLabel.text + label.text
                 } else if (titleName == "verifyLock") {
                     verifyLabel.text = verifyLabel.text + label.text
                 }
             }               
        }
    ]
}