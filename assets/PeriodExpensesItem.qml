import bb.cascades 1.0

Container {
    id: expenseItem
	layout: StackLayout { orientation: LayoutOrientation.LeftToRight }
	background: periodExpensesComp.ListItem.indexInSection % 2 ? Color.White : Color.create("#ececec")
	topPadding: 6
	bottomPadding: 15
	leftPadding: 15
	rightPadding: 25
	
	Container {
	    layoutProperties: StackLayoutProperties { spaceQuota: -1 }
	    topPadding: 7
	    rightPadding: 5
	    verticalAlignment: VerticalAlignment.Center
	    ImageView { imageSource: "asset:///images/tabicons/" + ListItemData.icon + ".png" }
    }
    
    Container {
	    id: descItem
	    layout: StackLayout {}
	    layoutProperties: StackLayoutProperties { spaceQuota: 2 }
	    leftPadding: 5
		Label {
		    textStyle { fontSize: FontSize.Large }
		    bottomMargin: 0
		    text: ListItemData.title
		}
		Label {
		    textStyle { fontSize: FontSize.Small }
		    topMargin: 0
		    text: ListItemData.dated
		}
    }
    
	Label {
	    layoutProperties: StackLayoutProperties { spaceQuota: 1 }
	    verticalAlignment: VerticalAlignment.Center
	    textStyle { 
	        fontSize: FontSize.Large 
	        //color: Color.create("#a30a0a")
	        color: Color.Black
	        textAlign: TextAlign.Right
	    }
	    preferredWidth: 300
	    text: "$"+addComma(ListItemData.amount)
	}
	
	function addComma(amount) {
	    var amountArray = amount.toString().split(".");
	    return amountArray[0].replace(/\B(?=(\d{3})+(?!\d))/g, ",") + (amountArray[1] ? "." + amountArray[1] : "");
	}
}