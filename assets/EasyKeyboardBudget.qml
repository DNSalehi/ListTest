import bb.cascades 1.0

Container {
    id: easyKeyboard
    layout: AbsoluteLayout {}
    ImageView {
        imageSource: "asset:///images/keyboardBackdrop.png"
    }

	Container {
	    layout: DockLayout {}
	     layoutProperties: AbsoluteLayoutProperties {
             positionY: 40    
             positionX: 63
         }  
         
         Container {
             horizontalAlignment: HorizontalAlignment.Center
             layout: AbsoluteLayout {} 
             
            EasyKey {
	            id: one
	        }
	        EasyKey {
	            id: two
	            layoutProperties: AbsoluteLayoutProperties {
	                positionX: 221    
	            } 
	            text: "2"
	        }
	        EasyKey {
	            id: three
	            layoutProperties: AbsoluteLayoutProperties {
	                positionX: 442  
	            } 
	            text: "3"
	        }
	    }
	}
	    
	Container {
	    horizontalAlignment: HorizontalAlignment.Center
	    layoutProperties: AbsoluteLayoutProperties {
	         positionY: 182   
	         positionX: 63
	     } 
	     Container {
	          layout: AbsoluteLayout {} 
			EasyKey {
			    id: four
			    text: "4"
			}
			EasyKey {
			    id: five
			    layoutProperties: AbsoluteLayoutProperties {
	             positionX: 221    
	             } 
			    text: "5"
			}
			EasyKey {
			    id: six
			    layoutProperties: AbsoluteLayoutProperties {
	             positionX: 442   
	             } 
			    text: "6"
			}
			}
    }
		
 	Container {
 	    horizontalAlignment: HorizontalAlignment.Center
 	    layoutProperties: AbsoluteLayoutProperties {
 	         positionY: 324   
 	         positionX: 63
 	     } 
 	     Container {
 	          layout: AbsoluteLayout {} 
		EasyKey {
		    id: seven
		    text: "7"
		}
		EasyKey {
		    id: eight
		    layoutProperties: AbsoluteLayoutProperties {
		         positionX: 221    
		     } 
		    text: "8"
		}
		EasyKey {
		    id: nine
		    layoutProperties: AbsoluteLayoutProperties {
		         positionX: 442    
		     } 
		    text: "9"
		}
		}
   }   
   
   Container {
       horizontalAlignment: HorizontalAlignment.Center
       layoutProperties: AbsoluteLayoutProperties {
            positionY: 466
            positionX: 63
        } 
        Container {
             layout: AbsoluteLayout {} 
             
             ActionKeyBudget {
                 id: delKey
                 text: ""
                 actionImage: "asset:///images/deleteSymbol.png"
             }
             
             EasyKey {
                 id: zero
                 layoutProperties: AbsoluteLayoutProperties {
                     positionX: 221    
                 } 
                 text: "0"
             }
             
             ActionKeyBudget {
                 id: saveKey
                 text: "Done"
                 layoutProperties: AbsoluteLayoutProperties {
                     positionX: 442
                 }
             }
         }
     }   
}