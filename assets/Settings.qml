import bb.cascades 1.0

Page {
    id: settingsPage

    Container {
        layout: StackLayout {}
        topPadding: 25
        
	    ImageView {
	        horizontalAlignment: HorizontalAlignment.Center
	        imageSource: "asset:///images/sblogo.png"
	    }
	    Container {
	        topPadding: 50
	        
	        Container {
	            rightPadding: 50
	            leftPadding: 50
	            horizontalAlignment: HorizontalAlignment.Center
	            Label {
	                multiline: true
	                textStyle {
	                    textAlign: TextAlign.Center
	                }
	                text: "Our goal is to make it easy for you to control your spendings and save money. That's why we plan to add a number of additional features that suit our customer's needs."
	            }
	        }
	        
		    Container {
		        topPadding: 100
		        rightPadding: 50
		        leftPadding: 50
		        horizontalAlignment: HorizontalAlignment.Center
			    Label {
			        multiline: true
			        textStyle { 
			            textAlign: TextAlign.Center
			        }
			        text: "Is there a feature you would like to see, or a bug to report?"
			    }
			}
		    
		    Button {
		        topMargin: 30
		        horizontalAlignment: HorizontalAlignment.Center  
		        text: "Email us!"

		        onClicked: {
		            console.log("Sending email")
		            budgetApp.sendEmail()
		            console.log("SENT")
		        }
		    }
		    
		    Container {
		        horizontalAlignment: HorizontalAlignment.Center
		        topPadding: 80
		        leftPadding: 50
		        rightPadding: 50
			    Label {
			        multiline: true
			        textStyle { 
			            textAlign: TextAlign.Center
			        }
			        text: "Tell us what you think of the app so far!"
			    }
			}
			    
		    Button {
		        topMargin: 30
		        horizontalAlignment: HorizontalAlignment.Center  
		        text: "Review us!"
		        attachedObjects: [
		            Invocation {
		                id: invokeReview   
		                query {
		                    mimeType: "application/x-bb-appworld"
		                    uri: "appworld://content//124432" //Change the number to your app id
		                }
		            }
		        ]
		        
		        onClicked: {
		            console.log("Open review")
		            invokeReview.trigger("bb.action.OPEN")
		        }
		    }
		}
	}
}