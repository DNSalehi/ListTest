import bb.cascades 1.0

Container {
    id: easyKeyboard
    layout: AbsoluteLayout {}
    
	Container {
	     layoutProperties: AbsoluteLayoutProperties {
             positionY: 0    
         }  
         Container {
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
	    layoutProperties: AbsoluteLayoutProperties {
	         positionY: 142   
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
 	    layoutProperties: AbsoluteLayoutProperties {
 	         positionY: 284   
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
       layoutProperties: AbsoluteLayoutProperties {
            positionY: 426
        } 
        Container {
             layout: AbsoluteLayout {} 
             
             ActionKey {
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
             
             ActionKey {
                 id: saveKey
                 text: "Save"
                 layoutProperties: AbsoluteLayoutProperties {
                     positionX: 442
                 }
             }
         }
     }   
}