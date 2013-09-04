import bb.cascades 1.0
    
Page {
    id: tutorialPage
    objectName: "tutorialPage"
    property int downX: 0
    property int downY: 0
    property int imageOffset: 0
    property int selectedImage: 1
    property alias botImage: bot.imageSource
    property bool isDown: false
    
    Container {
        layout: DockLayout {}
        Container {
            verticalAlignment: VerticalAlignment.Top
            layout: StackLayout  {orientation: LayoutOrientation.LeftToRight}
            id: slideContainer
            minWidth: 4608 //Width of all images combined, or width of number of screens combined
            
            ImageView {
                id: img1
                leftMargin: 0
                rightMargin: 0
                imageSource: "asset:///images/tutorial/1.png"
            }
            
            ImageView {
                id: img2
                leftMargin: 0
                rightMargin: 0
                imageSource: "asset:///images/tutorial/2.png"
            }
            
            ImageView {
                id: img3
                leftMargin: 0
                rightMargin: 0
                imageSource: "asset:///images/tutorial/3.png"
            }
            
            ImageView {
                id: img4
                leftMargin: 0
                rightMargin: 0
                imageSource: "asset:///images/tutorial/4.png"
            }
            
            ImageView {
                id: img5
                leftMargin: 0
                rightMargin: 0
                imageSource: "asset:///images/tutorial/5.png"
            }
            
            ImageView {
                id: img6
                leftMargin: 0
                rightMargin: 0
                imageSource: "asset:///images/tutorial/6.png"
            }
            
            onTouch: {
                if (event.windowX > 0 || event.windowY > 0) {
                    if (event.isDown()) {
                        isDown = true;
                        //Save touch down coordinates
                        downX = event.localX;
                        downY = event.localY;
                    } else if (event.isMove()) {
                        if (isDown) {
                            //Set container's position to that of the user's touch
                            slideContainer.translationX = event.localX - downX + imageOffset;
                            console.log("event.localX: " + event.localX + "event.windowX: " + event.windowX);
                        }
                    } else if (event.isUp()) {
                        isDown = false;
                        //On release, check position of container and decide where to snap the container to
                        console.log("Up at: " + slideContainer.translationX);
                        console.log("selectedImage: " + selectedImage);
                        
                        //Check distance moved, and if it is at the first or last image
                        if ((slideContainer.translationX < (-150 + imageOffset)) && selectedImage < 6) {
                            slideContainer.translationX = -768 + imageOffset;
                            imageOffset -= 768; //Go forward the width of image/screen
                            selectedImage++;
                            //Change bottom dot image
                            botImage = "asset:///images/tutorial/" + selectedImage + "bot.png"
                            console.log("Go to next slide.");
                        } else if ((slideContainer.translationX > (150 + imageOffset)) && selectedImage > 1)  {
                            slideContainer.translationX = 768 + imageOffset;
                            imageOffset += 768; //Go backward the width of image/screen
                            selectedImage--;
                            //Change bottom dot image
                            botImage = "asset:///images/tutorial/" + selectedImage + "bot.png"
                            console.log("Go to previous slide.");
                        } else {
                            console.log("Reset position of slide.");
                            slideContainer.translationX = imageOffset; //Reset to current image on screen
                        }
                    }
                } else {
                    isDown = false;
                    //On release, check position of container and decide where to snap the container to
                    console.log("WENT OFF SCREEN");
                    console.log("Up at: " + slideContainer.translationX);
                    console.log("selectedImage: " + selectedImage);
                    
                    //Check distance moved, and if it is at the first or last image
                    if ((slideContainer.translationX < (-150 + imageOffset)) && selectedImage < 6) {
                        slideContainer.translationX = -768 + imageOffset;
                        imageOffset -= 768; //Go forward the width of image/screen
                        selectedImage++;
                        //Change bottom dot image
                        botImage = "asset:///images/tutorial/" + selectedImage + "bot.png"
                        console.log("Go to next slide.");
                    } else if ((slideContainer.translationX > (150 + imageOffset)) && selectedImage > 1)  {
                        slideContainer.translationX = 768 + imageOffset;
                        imageOffset += 768; //Go backward the width of image/screen
                        selectedImage--;
                        //Change bottom dot image
                        botImage = "asset:///images/tutorial/" + selectedImage + "bot.png"
                        console.log("Go to previous slide.");
                    } else {
                        console.log("Reset position of slide.");
                        slideContainer.translationX = imageOffset; //Reset to current image on screen
                    }
                }
            }
        }
        
        Container {
            layout: DockLayout {}
            verticalAlignment: VerticalAlignment.Bottom
            id: bottomContainer
            minWidth: 768
            
            ImageView {
                id: bot
                leftMargin: 0
                rightMargin: 0
                imageSource: "asset:///images/tutorial/1bot.png"
            }
            
            Container {
                layout: StackLayout {}
                horizontalAlignment: HorizontalAlignment.Right
                minWidth: 190
                minHeight: 74
                Container {
                    topPadding: 6
                    horizontalAlignment: HorizontalAlignment.Center
                    verticalAlignment: VerticalAlignment.Center
                    Label {
                        text: selectedImage < 6 ? "Skip" : "Start"  
                        textStyle { 
                            fontSize: FontSize.Large 
                            color: Color.White
                            textAlign: TextAlign.Center
                        }   
                    } 
                }
                onTouch: {
                    if (event.isUp()) {
                        console.log("Skip tutorial");
                        endTutorial();
                    }
                }
            }
        }
    }
    function endTutorial() {
        console.log("Exiting tutorial")   
        budgetApp.loadAccountCreation()
    }
}