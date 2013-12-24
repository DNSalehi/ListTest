import bb.cascades 1.0

    Page {
        id: createPage
        objectName: "createAccountPage"
        property bool openedKeyboardBool: false
        property string titleName: "createAccountPage"
        property string accountName
        property string accountBudget
        property string budgetType
        property alias nameBG: nameBorder.background
        property alias nameText: nameField.text
        
        titleBar: TitleBar {
            id: createAccountBar
            title: "Create Account"
            visibility: ChromeVisibility.Visible
            
            acceptAction: ActionItem { 
                title: "Save"
                onTriggered: {
                    if (nameText == "") {
                        console.log("Has no name")
                        nameBG = Color.Red
                    } else {
                        nameBG = null
	                    // Hide the Sheet and emit signal that the item should be saved.
	                    containerDown()
	                    budgetApp.createAccount(nameField.text, budgetField.text, dropDownPeriod.selectedValue, startDatePicker.value, endDatePicker.value);
	                    closeKeyboard()
	                    openedKeyboardBool = false;
	                    budgetApp.clearBudgetAmount()
	                    budgetApp.loadQMLScene()
	                }
                }
            }
       }
               
       Container {
           layout: AbsoluteLayout {}
           
           Container {
               layout: AbsoluteLayout {}
               layoutProperties: AbsoluteLayoutProperties {
                   positionX: 0
                   positionY: 550
               }
               //horizontalAlignment: HorizontalAlignment.Center
               
               EasyKeyboardBudget {
                   id: easyKeyboardBudget
                   layoutProperties: AbsoluteLayoutProperties {
                       positionX: 0
                       positionY: 620
                   }
                   animations: [
                       TranslateTransition {
                           id: showKeyboardAnim
                           fromY: 0
                           toY: -620
                           duration: 230
                       },
                       TranslateTransition {
                           id: hideKeyboardAnim
                           fromY: -620
                           toY: 0
                           duration: 0
                       }
                   ]
               }
           }
           
           Container {
               layout: StackLayout {}
               layoutProperties: AbsoluteLayoutProperties {
                   positionY: 70
                   positionX: 22
               }
               preferredWidth: 723
               Container {
	               id: nameBorder

	               rightPadding: 2
	               leftPadding: 2
	               topPadding: 2
	               bottomPadding: 2
	               horizontalAlignment: HorizontalAlignment.Center
	               
	               TextField {
	                   id: nameField 
	                   objectName: "nameField"
	                   preferredWidth: 723
	                   hintText: "Enter account title"
	                   focusHighlightEnabled: false
	               }
	           }
               
               DropDown {
                   id: dropDownPeriod
                   objectName: "dropDownPeriod"
                   topMargin: 50
                   title: "Period"
                   enabled: true
                   horizontalAlignment: HorizontalAlignment.Center
                   
                   onFocusedChanged: {
                       if (focused) {
                           if (openedKeyboardBool) {
                               closeKeyboard()
                               containerDown()
                               openedKeyboardBool = false
                           }
                      }   
                  }
                   
                   onSelectedIndexChanged: {
                       console.log("dropDownPeriod->onSelectedIndexChanged")
	                   setPeriodDay(selectedValue)
                   }
                   
                   Option {
                       id: monthly
                       text: "Monthly"
                       value: "monthly"
                       
                       onSelectedChanged: {
                           if (selected == true) {
                               console.log("Monthly selected.")
                           }
                       }
                   }
                   
                   Option {
                       id: weekly
                       text: "Weekly"
                       value: "weekly"
                       
                       onSelectedChanged: {
                           if (selected == true) {
                               console.log("Weekly selected.")
                           }
                       }
                   }
                   
                   Option {
                       id: biweekly
                       text: "Biweekly"
                       value: "biweekly"
                       
                       onSelectedChanged: {
                           if (selected == true) {
                               console.log("Biweekly selected.")
                           }
                       }
                   }
                   
                   Option {
                       id: daily
                       text: "Daily"
                       value: "daily"
                       
                       onSelectedChanged: {
                           if (selected == true) {
                               console.log("Daily selected.")
                           }
                       }
                   }
                   
                   Option {
                       text: "Yearly"
                       value: "yearly"
                       
                       onSelectedChanged: {
                           if (selected == true) {
                               console.log("Yearly selected.")
                           }
                       }
                   }
                   
                   function setDropDownOptionByValue(newValue) {
                      for (var i = 0; i < dropDownPeriod.options.length; i++) {
                          var o = dropDownPeriod.options[i];
                          if (o.value == newValue) {
                              console.log("found match")
                              console.log("indexOf(o) returns: " + indexOf(o))
                              dropDownPeriod.setSelectedIndex(indexOf(o));
                              return true;
                          }
                      }
                      return false;
                  }
               }
               
               DateTimePicker {
                   id: startDatePicker
                   horizontalAlignment: HorizontalAlignment.Center
                   topMargin: 50
                   title: "Start Date"
                   
                   onFocusedChanged: {
                       if (focused) {
                           if (openedKeyboardBool) {
                               closeKeyboard()
                               containerDown()
                               openedKeyboardBool = false
                           }
                       }   
                   }
               
                   onValueChanged: {
                       console.log("startDatePicker->onValueChanged")
                       endDatePicker.setBudgetEndDate() 
                   }
               }
               
               DateTimePicker {
                   id: endDatePicker
                   topMargin: 50
                   horizontalAlignment: HorizontalAlignment.Center
                   enabled: false
                   title: "End Date"
               
                   function setBudgetEndDate() {
                       var budgetType = dropDownPeriod.selectedValue
                       var startingDay = startDatePicker.value
                       var endingDay = startingDay
                       
                       console.log("setBudgetEndDate->startDate: " + startingDay)
                       
                       if(budgetType == "monthly") {
                           if (endingDay.getMonth() == 12) {
                               endingDay.setMonth(1)
                               endingDay.setFullYear(parseInt(endingDay.getFullYear()) + 1)
                               endingDay = subtractDays(endingDay,1)
                           } else {
                               endingDay.setMonth(endingDay.getMonth() + 1)
                               endingDay = subtractDays(endingDay,1)
                           }
                       } else if (budgetType == "weekly") {
                           console.log("setBudgetEndDate->endingDay before-> " + endingDay)
                           endingDay = addDays(endingDay,6)
                           console.log("setBudgetEndDate->endingDay after-> " + endingDay)
                       } else if (budgetType == "biweekly") {
                           endingDay = addDays(endingDay,13)   
                       } else if (budgetType == "yearly") {
                           endingDay.setFullYear((parseInt(endingDay.getFullYear()) + 1)) 
                           endingDay = subtractDays(endingDay,1)
                       } else if (budgetType == "daily") {
                           //Starts same day it ends, so nothing changes
                       }
                       console.log("Set end date: " + endingDay)
                       
                       endDatePicker.value = Qt.formatDateTime(endingDay,'yyyy-MM-dd')
                   }
                   
                   function periodChanged(startDate) {
                       console.log("periodChanged: " + startDate)
                       console.log("||startDatePicker.value = " + startDatePicker.value + " ||startDate = " + startDate + " ||qtFormat = " + Qt.formatDateTime(startDate,'yyyy-MM-dd') + " ||qtFormatPicker = " + Qt.formatDateTime(startDatePicker.value,'yyyy-MM-dd'))
                       if (Qt.formatDateTime(startDatePicker.value, 'yyyy-MM-dd') == startDate) {   
                           console.log("Running setBudgetEndDate()!!!!")
                           endDatePicker.setBudgetEndDate() 
                       } else {
                           console.log("Attempting to set startDatePicker.value to: " + startDate)
                           startDatePicker.value = startDate
                       }
                   }
               }
               
               TextField {
                   id: budgetField 
                   objectName: "budgetField"
                   preferredWidth: 723
                   topMargin: 50
                   horizontalAlignment: HorizontalAlignment.Center
                   input.flags: TextInputFlag.VirtualKeyboardOff
                   hintText: "Amount"
                   text: "$0.00"
                   
                   onFocusedChanged: {
                       if (focused && !openedKeyboardBool) {
                           containerUp()
                           openKeyboard()   
                           openedKeyboardBool = true
                       }
                   }
               }
               
               animations: [
                   TranslateTransition {
                       id: moveContainerDown
                       fromY: -250
                       toY: 0
                       duration: 0
                   },
                   TranslateTransition {
                       id: moveContainerUp
                       fromY: 0
                       toY: -250
                       duration: 0
                   }
               ]
           }
       }
   
  function openKeyboard() {
       showKeyboardAnim.play()
  }
  
  function closeKeyboard() {
      hideKeyboardAnim.play()    
  }
      
  function containerUp() {
      moveContainerUp.play() 
  }
      
  function containerDown() {
      moveContainerDown.play()
  }
  
  function getPageName() {
      return titleName
  }
   
   function setPeriodDay(periodType) {
       var currentDate = new Date()
       var dayNum = currentDate.getDay()
       var monthNum = currentDate.getMonth()
       var yearNum = currentDate.getFullYear()
       var lastDayMonth = new Date(yearNum, monthNum, 0)
       var daysInMonth = lastDayMonth.getDate()
       
       console.log("OG currentDate: " + currentDate)
       console.log("Attempting to set period, periodType:" + periodType)
       if (periodType == "monthly") {
           if (monthNum != 0) {
               currentDate.setDate(1)
           }
       } else if (periodType == "weekly") {
           if (dayNum != 1) {
               //It's not Sunday, therefore you have to subtract
               
               var firstDayOfPeriod = currentDate.getDate() - dayNum
               var lastDayOfPeriod = firstDayOfPeriod + 6
               
               if (firstDayOfPeriod < 1) {
                   if(monthNum == 1) {
                      yearNum -= 1
                      monthNum = 12;
                      lastDayMonth = new Date(yearNum,monthNum,0)
                      daysInMonth = lastDayMonth.getDate()
                   } else {
                       monthNum -= 1;
                   }  
                   currentDate.setMonth(monthNum)
                   currentDate.setFullYear(yearNum)
                   firstDayOfPeriod = daysInMonth + firstDayOfPeriod
               }
               console.log("Chose " + periodType + ", first day of week is "  + firstDayOfPeriod + " and last day is " + lastDayOfPeriod) 
               currentDate.setDate(firstDayOfPeriod)  
           }
       } else if (periodType == "biweekly") {
           if (dayNum != 1) {
               var firstDayOfPeriod = currentDate.getDate() - dayNum
               var lastDayOfPeriod = firstDayOfPeriod + 13  
               
               if (firstDayOfPeriod < 1) {
                   if(monthNum == 1) {
                      yearNum -= 1
                      monthNum = 12;
                      lastDayMonth = new Date(yearNum,monthNum,0)
                      daysInMonth = lastDayMonth.getDate()
                   } else {
                       monthNum -= 1;
                   }  
                   currentDate.setMonth(monthNum)
                   currentDate.setFullYear(yearNum)
                   firstDayOfPeriod = daysInMonth + firstDayOfPeriod
               }
               console.log("Chose " + periodType + ", first day is "  + firstDayOfPeriod + " and last day is " + lastDayOfPeriod)
               currentDate.setDate(firstDayOfPeriod) 
           }
       } else if (periodType == "yearly") {
           console.log("Read as yearly")
           if (dayNum == 1 && monthNum == 0) {
               console.log("Reads as first day of year")
               //It is the first day of the year
           } else {
               console.log("Sets to first day of year")
               currentDate.setDate(1)
               currentDate.setMonth(0)
           }
       }
       console.log("Setting value in periodDay:" + currentDate)
       console.log("||startDatePicker.value = " + startDatePicker.value + " ||startDate = " + currentDate + " ||qtFormat = " + Qt.formatDateTime(currentDate,'yyyy-MM-dd') + " ||qtFormatPicker = " + Qt.formatDateTime(startDatePicker.value,'yyyy-MM-dd'))
       if (Qt.formatDateTime(startDatePicker.value, 'yyyy-MM-dd') == Qt.formatDateTime(currentDate,'yyyy-MM-dd')) {   
           endDatePicker.setBudgetEndDate() 
       } else {
           startDatePicker.value = Qt.formatDateTime(currentDate,'yyyy-MM-dd')
       }
   }
   
   function addDays(myDate,days) {
       var tempDate = new Date(myDate.getTime() + days*24*60*60*1000);
       var day = tempDate.getDate();
       var month = tempDate.getMonth();
       var year = tempDate.getFullYear();
                       
       tempDate.setDate(day)
       tempDate.setMonth(month)
       tempDate.setFullYear(year)
                       
       return tempDate
   }
                   
   function subtractDays(myDate,days) {
       console.log("myDate is: " + myDate)
       var tempDate = new Date(myDate.getTime() - days*24*60*60*1000);
       var day = tempDate.getDate();
       var month = tempDate.getMonth();
       var year = tempDate.getFullYear();
                       
       tempDate.setDate(day)
       tempDate.setMonth(month)
       tempDate.setFullYear(year)
                       
       return tempDate
   }   
   }// Page