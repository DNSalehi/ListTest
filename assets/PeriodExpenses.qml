import bb.cascades 1.0
import bb.system 1.0

Page {
    titleBar: TitleBar {
        title : "Past expenses"
    }
    
    Container {
        layout: StackLayout {}
        
        ListView {
            id: periodExpensesListView
            objectName: "periodExpensesListView"
            dataModel: XmlDataModel { }
            listItemComponents: [
                ListItemComponent {
                    type: "header"
                },
                ListItemComponent {
                    type: "item"
                    Container {
                        id: periodExpensesComp
                        PeriodExpensesItem {}
                        Divider {
                            topMargin: 0
                            bottomMargin: 0
                        }
                    }
                }
            ]
            attachedObjects: [
                GroupDataModel {
                    id: expenseModel
                    sortingKeys: ["yearRank", "monthRank", "dayRank", "hourRank", "minuteRank", "secondRank"]
                }
            ]
        }
        
    }   
}