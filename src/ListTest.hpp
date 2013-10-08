// Default empty project template
#ifndef ListTest_HPP_
#define ListTest_HPP_

#include <QObject>
#include <QDate>
#include <QTimer>
#include <bb/cascades/ListView>
#include <bb/cascades/Application>
#include <bb/cascades/QListDataModel>
#include <bb/cascades/GroupDataModel>
#include <bb/data/JsonDataAccess>
#include <bb/cascades/ImageView>
#include <bb/cascades/AbsoluteLayoutProperties>
#include <bb/cascades/TabbedPane>
#include <bb/cascades/NavigationPane>
#include <bb/cascades/Label>
#include <bb/cascades/Page>
#include <bb/cascades/DropDown>
#include <bb/cascades/Sheet>
#include <bb/cascades/TextField>
#include <bb/system/InvokeManager>
#include <bb/system/SystemToast>
#include <bb/system/SystemDialog>
#include <bb/platform/Notification>
#include <bb/platform/NotificationDialog>
#include <bb/platform/NotificationError>
#include <bb/platform/NotificationResult>

using namespace bb::cascades;
using namespace bb::data;
using namespace bb::system;

/*!
 * @brief Application pane object
 *
 *Use this object to create and init app UI, to create context objects, to register the new meta types etc.
 */
class ListTest : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString budgetType READ budgetType)
    Q_PROPERTY(QString budgetStartDate READ budgetStartDate)

public:
    ListTest();
    ~ListTest();
    //DatabaseManager mdatabaseManager;
    Q_INVOKABLE void addNewRecord(const QString &expenseName, QString expenseAmount,
            const QString &expenseDate,
            const QString &expenseCategory,
            const QString &fullDate);
    Q_INVOKABLE void updateSelectedRecord(const QVariant &selectedIndex, QString expenseAmount,
    		const QString &expenseName,
            const QString &expenseDate,
            const QString &expenseCategory);
    Q_INVOKABLE void deleteItemAtIndex(QVariant selectedExpense);
    Q_INVOKABLE void setBudget(const QString &expenseAmount, const QString &budgetType, const QString &startDate, const QString &endDate, bool firstTime = false);
    Q_INVOKABLE void createAccount(const QString &accountName, const QString &expenseAmount, const QString &budgetType, const QString &startDate, const QString &endDate);
    Q_INVOKABLE void addAccount(const QString &accountName, const QString &expenseAmount, const QString &budgetType, const QString &startDate, const QString &endDate);
    Q_INVOKABLE void setAccount(QVariant selectedAccount);
    Q_INVOKABLE void updateSumAmount(const QString &keyPressed, const QString &fromPage);
    Q_INVOKABLE void updatePinSumAmount(const QString &keyPressed, const QString &fromPage);
    Q_INVOKABLE void onStart();
    Q_INVOKABLE void clearAmountText();
    Q_INVOKABLE void clearEditAmountText();
    Q_INVOKABLE void clearBudgetAmount();
    Q_INVOKABLE void updateSumAmountSymbol(const QString &keyPressed, const QString &fromPage);
    Q_INVOKABLE void editAmountText(const QString &currentAmount);
    Q_INVOKABLE void createPin();
    Q_INVOKABLE void deletePinAmount(const QString &fromPage);
    Q_INVOKABLE void getCreateLabel();
    Q_INVOKABLE void getVerifyLabel();
    Q_INVOKABLE void lockApp(const QString &lock);
    Q_INVOKABLE void fillBudgetPage();
    Q_INVOKABLE void fillAddAccount();
    Q_INVOKABLE void changeAccountName(const QString &previousID, const QString &newName);
    Q_INVOKABLE void deleteAccount(const QString &previousID, int selectedIndex);
    Q_INVOKABLE void newPeriod(QString endDateStr);
    Q_INVOKABLE void updatePeriodExpensesListView(const QString &date1, const QString &date2);
    Q_INVOKABLE void loadAccountCreation();
    Q_INVOKABLE void reloadWebView();
    Q_INVOKABLE void sendEmail();
    Q_INVOKABLE void setUpAccountListModel();
    Q_INVOKABLE void updateBar();
    Q_INVOKABLE bool loadQMLScene();
    Q_INVOKABLE bool verifyPin(const QString &pin);
    Q_INVOKABLE bool hasPin();
    Q_INVOKABLE bool getLockedStatus();
    Q_INVOKABLE QString getAccountName();
    Q_INVOKABLE QString getCurrentBudget(const QString &selectedAccountID = "");
    Q_INVOKABLE QString getUsedBudget(const QString &selectedAccountID = "");
    Q_INVOKABLE QString getBudgetType(const QString &selectedAccountID = "");
    Q_INVOKABLE QString addDigitToValue(QString fullValue, QString digit);
    Q_INVOKABLE QString deleteDigitFromValue(QString fullValue);
    Q_INVOKABLE QVariantList getValueArray();
    bool removeFromPreviousPeriod(QVariantMap expenseMap);
    bool addToPreviousPeriod(QVariantMap expenseMap);
    QString convertDateNum(QString dateToConvert);
    QString addComma(QString &num);
    QString compareDates(QString date1, QString date2);
    QString amountText;
    QString convertDate(const QString &prevDate);
    QString fixForConversion(const QString &changeDate);
    QString budgetType();
    QString _budgetType;
    QString budgetStartDate();
    QString _budgetStartDate;
    QString _budgetEndDate;
    QString getNewEndDate(QDate newStartDate);
    QString isWithinRange(QString checkDate, QString startDate, QString endDate);
    QString toNumDate(const QString &prevDate);
    QString getIncrementingAccountID();
    QString currentAccountID;
    QString incrementingAccountID;
    QString getIncrementedID();
    QString rankItemYear(const QString &prevDate, QString token = " ");
    QString rankItemDay(const QString &prevDate, QString token = " ");
    QString rankItemMonth(const QString &prevDate, bool withZero = false, QString token = " ");
    QString rankItemHour(const QString &prevDate, QString token = " ");
    QString rankItemMinute(const QString &prevDate, QString token = " ");
    QString rankItemSecond(const QString &prevDate, QString token = " ");
    void loadLockScreen();
    void setAmountTextFormat(QString numPressed);
    void loadTimer();
    void loadSettings();
    void loadTutorial();
    void setUpExpenseListModel();
    void setUpPeriodExpensesListModel();
    void setUpPeriodListModel();
    void setUpAccountModel();
    void setPeriod(const QString &startDate, const QString &endDate);
    void updatePeriodView();
    void fastUpdateListView();
    void updateListView();
    void updateAccountView();
    void saveJson();
    void savePeriods();
    void saveExpenses();
    void saveAccountJson();
    void addPeriodExpenses();
    void removeExcessPeriod(QVariant excessPeriod);
    QDate getNewStartDate(QDate oldStartDate);
    QVariantList expenseList;
    QVariantList periodList;
    QVariantList accountList;
    QVariantList getCurrentExpenses(QVariantList prevList);
    QVariant getPrimaryAccount();
    QVariant getPrimaryPeriod();
    QVariant getPeriodOf(QVariantList selectedPeriodList);
    QVariant saveAccount(const QString &accountNameField, bool firstTime = false);
    QVariant primaryAccount;
    JsonDataAccess jda;
    AbsoluteLayoutProperties *expenseBarLayout;
    GroupDataModel *periodExpensesModel;
    GroupDataModel *periodModel;
    GroupDataModel *expenseModel;
    GroupDataModel *accountModel;
    TabbedPane *tabbedPane;
    Page *accountPage;
    Page *editPage;
    Page *lockSheetPage;
    Page *createAccountPage;
    Page *tutorialPage;
    NavigationPane *addPageNav;
    Sheet *lockSheet;
    ListView *periodExpensesListView;
    ListView *periodListView;
    ListView *expenseListView;
    ListView *accountListView;
    ListView *otherAccountList;
   	DropDown *dropDownPeriod;
    Label *createBudgetLabel;
    Label *spentLabel;
    Label *remainingLabel;
    Label *amountLabel;
    Label *amountLabelEdit;
    Label *createLabel;
    Label *verifyLabel;
    TextField *budgetField;
    TextField *budgetAmountField;
    ImageView *expenseBar;
    //Notification *mNotification;
    SystemDialog *dialog;
    QVariantMap accountMap;
    QVariantMap periodMap;

signals:
	void periodChanged(QString);
	void updateGraph(QVariant);
	void setAccountGraph();
	void reloadWeb();
	void emptyExpenseList();
	void notEmptyExpenseList();

public slots:
	Q_INVOKABLE void checkDate();
	void overBudgetDialogClose();
};


#endif /* ListTest_HPP_ */
