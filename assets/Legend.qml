import bb.cascades 1.0

Container {
    layout: StackLayout {}
    horizontalAlignment: HorizontalAlignment.Center
    
    Container {
	    topPadding: 35
	    layout: DockLayout {}
	    
	    Container {
	        layout: StackLayout { orientation: LayoutOrientation.LeftToRight }
	        leftPadding: 15
	        
		    ImageView {
		        id: image0
		        verticalAlignment: VerticalAlignment.Center
			}
			
			Label {
			    id: label0
			    leftMargin: 3
			    verticalAlignment: VerticalAlignment.Top
			}
        }
		    
		Container {
		    layout: StackLayout { orientation: LayoutOrientation.LeftToRight }
		    leftPadding: 380
		    
			ImageView {   
			    id: image1
			    verticalAlignment: VerticalAlignment.Center
			}
			
			Label {
			    id: label1
			    leftMargin: 3
			    verticalAlignment: VerticalAlignment.Top
			}
        }
    }
	
	Container {
	    topPadding: 40
	    layout: DockLayout {}
	    
	    Container {
	        layout: StackLayout { orientation: LayoutOrientation.LeftToRight }
	        leftPadding: 15
	        
		    ImageView {
		        id: image2
		        verticalAlignment: VerticalAlignment.Center
			}
			
			Label {
			    id: label2
			    leftMargin: 3
			    verticalAlignment: VerticalAlignment.Top
			}
        }
		    
		Container {
		    layout: StackLayout { orientation: LayoutOrientation.LeftToRight }
		    leftPadding: 380
		    
			ImageView {   
			    id: image3
			    verticalAlignment: VerticalAlignment.Center
			}
			
			Label {
			    id: label3
			    leftMargin: 3
			    verticalAlignment: VerticalAlignment.Top
			}
        }
    }
    
    Container {
	    topPadding: 40
	    layout: DockLayout {}
	    
	    Container {
	        layout: StackLayout { orientation: LayoutOrientation.LeftToRight }
	        leftPadding: 15
	        
		    ImageView {
		        id: image4
		        verticalAlignment: VerticalAlignment.Center
			}
			
			Label {
			    id: label4
			    leftMargin: 3
			    verticalAlignment: VerticalAlignment.Top
			}
        }
		    
		Container {
		    layout: StackLayout { orientation: LayoutOrientation.LeftToRight }
		    leftPadding: 380
		    
			ImageView {   
			    id: image5
			    verticalAlignment: VerticalAlignment.Center
			}
			
			Label {
			    id: label5
			    leftMargin: 3
			    verticalAlignment: VerticalAlignment.Top
			}
        }
    }
    
    Container {
	    topPadding: 40
	    layout: DockLayout {}
	    
	    Container {
	        layout: StackLayout { orientation: LayoutOrientation.LeftToRight }
	        leftPadding: 15
	        
		    ImageView {
		        id: image6
		        verticalAlignment: VerticalAlignment.Center
			}
			
			Label {
			    id: label6
			    leftMargin: 3
			    verticalAlignment: VerticalAlignment.Top
			}
        }
		    
		Container {
		    layout: StackLayout { orientation: LayoutOrientation.LeftToRight }
		    leftPadding: 380
		    
			ImageView {   
			    id: image7
			    verticalAlignment: VerticalAlignment.Center
			}
			
			Label {
			    id: label7
			    leftMargin: 3
			    verticalAlignment: VerticalAlignment.Top
			}
        }
    }
    
    function setPercentages() {
        var theLabels = []
        var labelRef = [label0,label1,label2,label3,label4,label5,label6,label7]
        var imageRef = [image0,image1,image2,image3,image4,image5,image6,image7]
        var sum = 0

        //Create markers
        for (var x = 0; x < dataArray.length; x++) {
            imageRef[x].imageSource = "asset:///images/Legend/marker" + x + ".png"   
        }   

        console.log("dataArray.length: " + dataArray.length)
         //Get sum of all numbers
        for (var i = 0; i < dataArray.length; i++) {
            console.log("dataArray[i]: " + dataArray[i].value)
            sum += parseFloat(dataArray[i].value);
        }   
        console.log("Sum set to: " + sum)
        
        console.log("reads sum as: " + sum)
        
        //Get percentage
        for (var j = 0; j < dataArray.length; j++) {
            theLabels.push(((dataArray[j].value/sum)*100).toFixed(1));
            //Shorten the word
            if (dataArray[j].category == "Entertainment") {
                labelRef[j].text = "Entertain.. " + theLabels[j] + "%";
            } else {
	            labelRef[j].text = dataArray[j].category + " " + theLabels[j] + "%";
	        }
        }   
    }
}