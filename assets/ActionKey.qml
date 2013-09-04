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
        text: "Save"            
    }
    
    ImageView { 
        id: actionImage
        horizontalAlignment: HorizontalAlignment.Center
        verticalAlignment: VerticalAlignment.Center
    }
    
    gestureHandlers: [
        TapHandler {
             onTapped: {
                 if (label.text != "Save") {
                     if (titleName == "addPage") {
                         var valueRec = "" + budgetApp.deleteDigitFromValue(amountLabel.text)
                         console.log("Recieved value addPage: " + valueRec)
                         amountLabel.text = valueRec;   
                     } else if (titleName == "editPage") {
                         console.log("Recieved value editPage")
                         amountLabelEdit.text = "" + budgetApp.deleteDigitFromValue(amountLabelEdit.text)
                     }
                 } else {
                     if (titleName == "addPage") {
	                     budgetApp.addNewRecord(expenseNameField.text == "" ? dropDown.selectedOption.text : expenseNameField.text, amountLabel.text,
	                     		                     datePicker.value, dropDown.selectedValue, setDate)
	                     switchToList()
	                     clearAdd()
	                 } else if (titleName == "editPage") {
	                     budgetApp.updateSelectedRecord(selectedItem, amountLabelEdit.text, expenseNameField.text == "" ? dropDown.selectedOption.text : expenseNameField.text,
                                                           datePicker.value, dropDown.selectedValue)
                         switchToList()
                         nav.pop()
                         clearAdd()
	                 }
                 }
             }                
        }
    ]
}