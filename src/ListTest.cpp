// Default empty project template
#include "ListTest.hpp"

#include <bb/cascades/Application>
#include <bb/cascades/QmlDocument>
#include <bb/cascades/AbstractPane>
#include <bb/cascades/GroupDataModel>
#include <bb/cascades/ListView>
#include <bb/cascades/NavigationPane>
#include <bb/cascades/TabbedPane>
#include <bb/cascades/Container>
#include <bb/cascades/Page>
#include <bb/cascades/QmlDocument>
#include <bb/data/JsonDataAccess>
#include <bb/cascades/QListDataModel>
#include <bb/cascades/advertisement/Banner>
#include <QString>
#include <QLocale>


using namespace bb::cascades;
using namespace bb::data;
using namespace bb::platform;
using namespace bb::cascades::advertisement;

ListTest::ListTest() {
}

ListTest::~ListTest() {
}

void ListTest::onStart() {
	QFile file(QDir::homePath() + QString("/user/accountinfo.json"));

	if (file.exists()) {
		//Load settings
		loadSettings();
	} else {
		QDir dir;
		dir.mkpath(QDir::homePath() + QString("/user"));
		loadTutorial();
	}
}

void ListTest::loadTimer() {
	QTimer *timer = new QTimer(this);
	connect(timer, SIGNAL(timeout()), this, SLOT(checkDate()));
	timer->start(5000);
}

void ListTest::loadSettings() {
	QCoreApplication::setOrganizationName("Salehisource");
	QCoreApplication::setApplicationName("SnapBudget");
	QSettings settings("Salehisource", "SnapBudget");

	if (settings.contains("isLocked")) {
		if (settings.value("isLocked") == "true") {
			//Have to set the page to lock mode
			loadLockScreen();
		} else {
			//Page not in lock mode
			loadQMLScene();
		}
	} else {
		//Lock mode never created
		settings.setValue("isLocked", "false");
	}
}

void ListTest::loadTutorial() {
	QmlDocument *qmlDocument = QmlDocument::create("asset:///Tutorial.qml").parent(this);
	if (!qmlDocument->hasErrors()) {
		qDebug() << "No errors in creating QML document!";
		qmlDocument->setContextProperty("budgetApp", this);
	}
	tutorialPage = qmlDocument->createRootObject<Page>();
	tutorialPage->setParent(this);

	Application::instance()->setScene(tutorialPage);
}

void ListTest::loadAccountCreation() {

	QmlDocument *qmlDocument = QmlDocument::create(
			"asset:///CreateAccount.qml").parent(this);
	if (!qmlDocument->hasErrors()) {
		qDebug() << "No errors in creating QML document!";
		qmlDocument->setContextProperty("budgetApp", this);
	}
	createAccountPage = qmlDocument->createRootObject<Page>();
	if (createAccountPage) {
		createAccountPage->setParent(this);
	}
	budgetField = createAccountPage->findChild<TextField*>("budgetField");
	dropDownPeriod = createAccountPage->findChild<DropDown*>("dropDownPeriod");
	dropDownPeriod->setSelectedIndex(0);

	Application::instance()->setScene(createAccountPage);
}

void ListTest::loadLockScreen() {
	QmlDocument *qmlDocument = QmlDocument::create(
			"asset:///LockPageVerify.qml").parent(this);
	if (!qmlDocument->hasErrors()) {
		qDebug() << "No errors in creating QML document!";
		qmlDocument->setContextProperty("budgetApp", this);
	}

	lockSheetPage = qmlDocument->createRootObject<Page>();
	lockSheetPage->setParent(this);
	Application::instance()->setScene(lockSheetPage);
}

void ListTest::checkDate() {
	if (periodMap["budgetAmount"] != "0") {
		//qDebug() << "Checking the date..";
		QDate currentDate = QDate::currentDate();
		QString currentDateStr = currentDate.toString("MM.dd.yyyy");
		QStringList currentDateStrList = currentDateStr.split(".");
		QString endDateConverted;

		//Checks if _budgetEndDate is in numeric form, if not converts it
		if (_budgetEndDate.at(0).isDigit()) {
			endDateConverted = _budgetEndDate;
		} else {
			QStringList endDateList = convertDate(_budgetEndDate).split(" ");
			endDateConverted = rankItemMonth(endDateList[0], true) + "."
					+ endDateList[1] + "." + endDateList[2];
		}

		QString comparedValue = compareDates(currentDateStr, endDateConverted);

		if (comparedValue == endDateConverted) {
			//qDebug() << "Today is before the end date";
		} else if (comparedValue == currentDateStr) {
			//qDebug() << "Today is past the end date";
			newPeriod(endDateConverted);
		} else if (comparedValue == "equal") {
			//qDebug() << "Today is the end date";
		}
	}
}

QVariantList ListTest::getValueArray() {
	QVariantList qList;
	QVariantMap qMap;

	return qList;
}

//Return larger date
QString ListTest::compareDates(QString date1, QString date2) {
	//qDebug() << "Today's date: " + date1 + " End date: " + date2;
	QStringList date1List = date1.split(".");
	QStringList date2List = date2.split(".");
	int date1Month = date1List[0].toInt();
	int date2Month = date2List[0].toInt();
	int date1Day = date1List[1].toInt();
	int date2Day = date2List[1].toInt();
	int date1Year = date1List[2].toInt();
	int date2Year = date2List[2].toInt();

	if (date1Year > date2Year) {
		return date1;
	} else if (date1Year < date2Year) {
		return date2;
	} else {
		if (date1Month > date2Month) {
			return date1;
		} else if (date1Month < date2Month) {
			return date2;
		} else {
			if (date1Day > date2Day) {
				return date1;
			} else if (date1Day < date2Day) {
				return date2;
			} else {
				return "equal";
			}
		}
	}
}

void ListTest::lockApp(const QString &lock) {
	QSettings settings("Salehisource", "SnapBudget");

	settings.setValue("isLocked", lock);
}

bool ListTest::getLockedStatus() {
	bool lockStatus = false;
	QSettings settings("Salehisource", "SnapBudget");

	if (settings.value("isLocked") == "true") {
		lockStatus = true;
	}

	return lockStatus;
}

QString ListTest::getAccountName() {
	QString accountName = accountMap["accountName"].toString();
	return accountName;
}

void ListTest::deleteAccount(const QString &previousID, int selectedIndex) {
	bool foundAccount = false;

	//Delete period file
	QFile file(
			QDir::homePath() + QString("/user/period_") + previousID
					+ QString(".json"));
	if (file.exists()) {
		if (file.remove()) {
			foundAccount = true;
		}
	}

	QVariant selectedAccount;

	foreach (QVariant it, accountList){
	QVariantMap iterateAccount = it.toMap();
	if (iterateAccount["accountID"] == previousID) {
		selectedAccount = iterateAccount;
		break;
	}
}
	if (foundAccount) {
		QVariantMap selectedMap = selectedAccount.toMap();
		int accountDataIndex = accountList.indexOf(selectedMap);
		accountList.removeAt(accountDataIndex);

		// ************
		// Once period is implemented, you must remove period file too!
		// ************

		//Checks if account was first on list, if so assigns next account as main
		if (selectedIndex == 0) {
			//Get the second account in list
			QVariant newAccount = accountList.at(0);
			QVariantMap newAccountMap = newAccount.toMap();
			primaryAccount = newAccount;
			accountMap = newAccountMap;

			_budgetType = periodMap["budgetType"].toString();
			_budgetStartDate = periodMap["startDate"].toString();
			_budgetEndDate = periodMap["endDate"].toString();
			accountMap["isMain"] = "true";

			accountList.replace(0, accountMap);
			//Clears previous ListView, in order to reload the ReportItems
			periodExpensesModel->clear();
			updatePeriodView();
			reloadWebView(false); //Clear and reload the line graph WebView
		}

		//Save to file
		saveAccountJson();
		//Update app components
		updateAccountView();
		//Ran in if statement above
		if (selectedIndex != 0)
			updatePeriodView();
		updateListView();
		updateBar();
	}
}

void ListTest::sendEmail() {
	InvokeRequest request;
	request.setUri("mailto:admin@salehisource.com?subject=Snapbudget%20Feedback");
	InvokeManager *invokeManager = new InvokeManager();
	invokeManager->invoke(request);
}

void ListTest::changeAccountName(const QString &previousID,
		const QString &newName) {
	QVariant selectedAccount;

	accountList =
			jda.load(QDir::homePath() + QString("/user/accountinfo.json")).value<
					QVariantList>();

	foreach (QVariant it, accountList){
	QVariantMap iterateAccount = it.toMap();
	if (iterateAccount["accountID"] == previousID) {
		selectedAccount = iterateAccount;
		break;
	}
}
	QVariantMap selectedMap = selectedAccount.toMap();
	int accountDataIndex = accountList.indexOf(selectedMap);
	selectedMap["accountName"] = newName;

	accountList.replace(accountDataIndex, selectedMap);

	//Save to file
	saveAccountJson();
	//Update app components
	updateAccountView();
}

QString ListTest::getCurrentBudget(const QString &selectedAccountID) {
	if (selectedAccountID != "") {
		QVariantList tempPeriodList = jda.load(
				QDir::homePath() + QString("/user/period") + QString("_")
						+ selectedAccountID + QString(".json")).value<
				QVariantList>();
		QVariant selectedPeriod = getPeriodOf(tempPeriodList);
		QVariantMap selectedPeriodMap = selectedPeriod.toMap();
		return selectedPeriodMap["budgetAmount"].toString();
	} else {
		return periodMap["budgetAmount"].toString();
	}
}

QString ListTest::getUsedBudget(const QString &selectedAccountID) {
	if (selectedAccountID != "") {
		QVariantList tempPeriodList = jda.load(
				QDir::homePath() + QString("/user/period") + QString("_")
						+ selectedAccountID + QString(".json")).value<
				QVariantList>();
		QVariant selectedPeriod = getPeriodOf(tempPeriodList);
		QVariantMap selectedPeriodMap = selectedPeriod.toMap();
		return selectedPeriodMap["budgetUsed"].toString();
	} else {
		return periodMap["budgetUsed"].toString();
	}
}

void ListTest::createPin() {
	QSettings settings("Salehisource", "SnapBudget");

	settings.setValue("pin", createLabel->text());

	SystemToast *toast = new SystemToast(this);

	toast->setBody("Set pin, save it somewhere so you don't forget!");
	toast->setPosition(SystemUiPosition::MiddleCenter);
	toast->show();
}

bool ListTest::verifyPin(const QString &pin) {
	QSettings settings("Salehisource", "SnapBudget");
	bool correctPinBool;

	qDebug() << "Verifying pin...";
	qDebug()
			<< QString("Is ") + pin + QString(" equal to ")
					+ settings.value("pin").toString();

	if (pin == settings.value("pin").toString()) {
		qDebug() << "Correct pin, access granted!";
		correctPinBool = true;
	} else {
		qDebug() << "Incorrect pin!";
		correctPinBool = false;
	}

	return correctPinBool;
}

bool ListTest::loadQMLScene() {
	// Registers the banner for QML
	qmlRegisterType<bb::cascades::advertisement::Banner>(
			"bb.cascades.advertisement", 1, 0, "Banner");

	QmlDocument *qmlDocument = QmlDocument::create("asset:///main.qml").parent(this);
	if (!qmlDocument->hasErrors()) {
		qDebug() << "No errors in creating QML document!";
		qmlDocument->setContextProperty("budgetApp", this);
	}

	tabbedPane = qmlDocument->createRootObject<TabbedPane>();
	tabbedPane->setParent(this);
	expenseListView = tabbedPane->findChild<ListView*>("expenseListView");
	expenseBar = tabbedPane->findChild<ImageView*>("expenseBar");
	spentLabel = tabbedPane->findChild<Label*>("spentLabel");
	remainingLabel = tabbedPane->findChild<Label*>("remainingLabel");
	createBudgetLabel = tabbedPane->findChild<Label*>("createBudgetLabel");
	amountLabel = tabbedPane->findChild<Label*>("amountLabel");

	setUpAccountModel();
	qDebug() << "Account Model set up complete.";
	setUpPeriodListModel();
	qDebug() << "Period List Model set up complete.";
	setUpExpenseListModel();
	qDebug() << "Expense List Model set up complete.";
	updateBar();
	qDebug() << "Bar update complete.";
	setUpPeriodExpensesListModel();
	qDebug() << "Period Expense List Model set up complete.";

	Application::instance()->setScene(tabbedPane);

	//Loading QTimer
	loadTimer();
	qDebug() << "Timer loaded.";

	//reloadWebView(); //Load the graph

	return true;
}

void ListTest::saveAccountJson() {
	jda.save(accountList, QDir::homePath() + "/user/accountinfo.json");

	if (jda.hasError()) {
		// Retrieve the error
		DataAccessError theError = jda.error();

		// Determine the type of error that occurred
		if (theError.errorType() == DataAccessErrorType::SourceNotFound)
			qDebug() << "Source not found: " + theError.errorMessage();
		else if (theError.errorType() == DataAccessErrorType::ConnectionFailure)
			qDebug() << "Connection failure: " + theError.errorMessage();
		else if (theError.errorType() == DataAccessErrorType::OperationFailure)
			qDebug() << "Operation failure: " + theError.errorMessage();
	} else {
		qDebug() << "No error.";
	}
	qDebug() << "Saved record to file!";
}

void ListTest::setAccount(QVariant selectedAccount) {
	//Get primary account
	primaryAccount = getPrimaryAccount();
	accountMap = primaryAccount.toMap();

	//Checks if the selected account is the current main account
	if (!(selectedAccount.toMap()["isMain"] == "true")) {
		QVariantMap testMap = selectedAccount.toMap();
		int accountDataIndex = accountList.indexOf(primaryAccount);
		//Sets selected account
		//Needs to set status of current isMain to false and selected isMain to true

		//Set current selected account isMain to false
		accountMap["isMain"] = "false";
		accountList.replace(accountDataIndex, accountMap);

		//Get accountMap of selected account
		accountMap = selectedAccount.toMap();
		accountDataIndex = accountList.indexOf(selectedAccount);
		qDebug() << "New index: " << accountMap["accountID"].toString();
		//Set selected account isMain to true
		accountMap["isMain"] = "true";
		//Breaks below...
		accountList.replace(accountDataIndex, accountMap);

		//Set primary account
		primaryAccount = selectedAccount;

		qDebug() << "1";
		updatePeriodView(); //Update period info to new account
		qDebug() << "2";
		//addPeriodExpenses(); Remove next time you see this.
		//Save to file
		qDebug() << "3";
		saveAccountJson();
		qDebug() << "4";
		//savePeriods(); Remove next time you see this.
		qDebug() << "5";

		//Update app components
		updateAccountView();
		//Clears previous ListView, in order to reload the ReportItems
		periodExpensesModel->clear();
		fastUpdateListView();
		updateBar();
		//Update line graph signal
		emit updateGraph(periodMap);
		reloadWebView(true); //Reload the line graph WebView

		//Set budget dates
		_budgetStartDate = periodMap["startDate"].toString();
		_budgetEndDate = periodMap["endDate"].toString();
		_budgetType = periodMap["budgetType"].toString();
	}
}

void ListTest::savePeriods() {
	jda.save(periodList,
			QDir::homePath() + "/user/period" + "_"
					+ accountMap["accountID"].toString() + ".json");

	if (jda.hasError()) {
		// Retrieve the error
		DataAccessError theError = jda.error();

		// Determine the type of error that occurred
		if (theError.errorType() == DataAccessErrorType::SourceNotFound)
			qDebug() << "Source not found: " + theError.errorMessage();
		else if (theError.errorType() == DataAccessErrorType::ConnectionFailure)
			qDebug() << "Connection failure: " + theError.errorMessage();
		else if (theError.errorType() == DataAccessErrorType::OperationFailure)
			qDebug() << "Operation failure: " + theError.errorMessage();
	} else {
		qDebug() << "No error.";
	}
	qDebug() << "Saved record to file!";
}

void ListTest::saveExpenses() {
	jda.save(expenseList,
				QDir::homePath() + "/user/expenses" + "_"
						+ accountMap["accountID"].toString() + ".json");
	if (jda.hasError()) {
		// Retrieve the error
		DataAccessError theError = jda.error();

		// Determine the type of error that occurred
		if (theError.errorType() == DataAccessErrorType::SourceNotFound)
			qDebug() << "Source not found: " + theError.errorMessage();
		else if (theError.errorType() == DataAccessErrorType::ConnectionFailure)
			qDebug() << "Connection failure: " + theError.errorMessage();
		else if (theError.errorType() == DataAccessErrorType::OperationFailure)
			qDebug() << "Operation failure: " + theError.errorMessage();
	} else {
		qDebug() << "No error.";
	}
	qDebug() << "Saved record to file!";
}

void ListTest::saveJson() {
	jda.save(accountList, QDir::homePath() + "/user/accountinfo.json");
	jda.save(periodList,
			QDir::homePath() + "/user/period" + "_"
					+ accountMap["accountID"].toString() + ".json");
	jda.save(expenseList,
			QDir::homePath() + "/user/expenses" + "_"
					+ accountMap["accountID"].toString() + ".json");

	if (jda.hasError()) {
		// Retrieve the error
		DataAccessError theError = jda.error();

		// Determine the type of error that occurred
		if (theError.errorType() == DataAccessErrorType::SourceNotFound)
			qDebug() << "Source not found: " + theError.errorMessage();
		else if (theError.errorType() == DataAccessErrorType::ConnectionFailure)
			qDebug() << "Connection failure: " + theError.errorMessage();
		else if (theError.errorType() == DataAccessErrorType::OperationFailure)
			qDebug() << "Operation failure: " + theError.errorMessage();
	} else {
		qDebug() << "No error.";
	}
	qDebug() << "Saved record to file!";
}

void ListTest::deleteItemAtIndex(QVariant selectedExpense) {
	QVariantMap expenseMap = selectedExpense.toMap();
	int itemDataIndex = expenseList.indexOf(expenseMap);
	int periodIndex = periodList.indexOf(periodMap);

	//Remove expense from expenseList
	expenseList.removeAt(itemDataIndex);
	//Remove expense from previous periods if needed
	if (removeFromPreviousPeriod(expenseMap)) {
		qDebug() << "Removed expense from previous period.";
	} else {
		qDebug() << "Expense was not needed to be removed from previous period";
	}

	//Modify budget in period
	float newAmount = periodMap["budgetUsed"].toFloat()
			- expenseMap["amount"].toFloat();
	QString qNewAmount;
	qNewAmount.sprintf("%.2f", newAmount);
	periodMap["budgetUsed"] = qNewAmount;
	periodMap["expenses"] = expenseList;

	//Replace current expenseList in periodList to updated expenseList
	periodList.replace(periodIndex, periodMap);

	saveJson();
	updatePeriodView();
	fastUpdateListView();
	updateBar();
	//Update line graph signal
	emit updateGraph(periodMap);//lavas erica chooper much
}

void ListTest::addAccount(const QString &accountName,
		const QString &expenseAmount, const QString &budgetType,
		const QString &startDate, const QString &endDate) {
	//Saves account, which returns a QVariant instance of the account thats is used to set the account
	setAccount(saveAccount(accountName, true));
	//Set the budget of the account
	setBudget(expenseAmount, budgetType, startDate, endDate, true);

	//Update lists
	updateAccountView();
	updateListView();
	updatePeriodView();
	reloadWebView(true);
	updateBar();
}

void ListTest::setBudget(const QString &expenseAmount,
		const QString &budgetType, const QString &startDate,
		const QString &endDate, bool firstTime) {
	QString expenseAmountS = expenseAmount;
	_budgetType = budgetType;
	_budgetStartDate = startDate;
	_budgetEndDate = endDate;

	QVariantList emptyList;

	expenseAmountS.remove("$");
	expenseAmountS.remove(",");
	float expenseAmountFloat = expenseAmountS.toFloat();
	expenseAmountS.sprintf("%.02f", expenseAmountFloat);

	//Get index of period
	int periodIndex = periodList.indexOf(periodMap);

	if (!firstTime) {
		periodMap["budgetType"] = budgetType;
		periodMap["budgetAmount"] = expenseAmountS;
	} else {
		periodMap["budgetType"] = budgetType;
		periodMap["budgetAmount"] = expenseAmountS;
		periodMap["budgetUsed"] = "0.00";
		periodMap["expenses"] = emptyList;
	}

	//Set period
	setPeriod(startDate, endDate);

	//Check if any periods have been saved
	if (periodList.count() > 0) {
		periodList.replace(periodIndex, periodMap);
	} else {
		periodList.insert(0, periodMap);
	}
	addPeriodExpenses();
	savePeriods();

	if (!firstTime) {
		qDebug() << "In if statement";
		updatePeriodView();
		qDebug() << "updatePeriodView()";
		fastUpdateListView();
		qDebug() << "fastUpdateListView()";
		updateBar();
		qDebug() << "updateBar()";
		//Update line graph signal
		emit updateGraph(periodMap);
	}
}

void ListTest::setPeriod(const QString &startDate, const QString &endDate) {
	//The end date of the budget will be the sorting ranks
	//Convert months to full name
	QString convertedDate = convertDate(endDate);
	QString convertedStartDate = convertDate(startDate);

	//Set period start and end dates
	periodMap["startDate"] = toNumDate(convertedStartDate);
	periodMap["endDate"] = toNumDate(convertedDate);
	//Using start date, can change back to convertedDate if it doesn't work
	periodMap["yearRank"] = rankItemYear(convertedStartDate);
	periodMap["dayRank"] = rankItemDay(convertedStartDate);
	periodMap["monthRank"] = rankItemMonth(convertedStartDate);
	periodMap["isMain"] = "true";
}

QString ListTest::budgetType() {
	return _budgetType;
}

QString ListTest::budgetStartDate() {
	return _budgetStartDate;
}

void ListTest::newPeriod(QString endDateStr) {
	//Notify user of period end
	float usedAmount = periodMap["budgetUsed"].toFloat();
	float totalAmount = periodMap["budgetAmount"].toFloat();
	float difference = totalAmount - usedAmount;
	QString differenceStr;
	differenceStr.sprintf("%.02f", difference);
	if (difference < 0) {
		dialog = new SystemDialog("Close");
		dialog->setTitle("Your period is complete!");
		dialog->setBody(
				"Amount over budget: $"
						+ QString::number((-1) * differenceStr.toFloat())
						+ "\n\nReview your spendings in the reports page and see what you can cut down on!");

		bool success = connect(dialog,
				SIGNAL(finished(bb::system::SystemUiResult::Type)), this,
				SLOT(overBudgetDialogClose()));
		if (success)
			dialog->show();
		else
			dialog->deleteLater();
	} else {
		dialog = new SystemDialog("Close");
		dialog->setTitle("Your period is complete!");
		dialog->setBody(
				"Amount saved: $" + QString::number(difference)
						+ "\n\nGreat job, keep it up!");

		bool success = connect(dialog,
				SIGNAL(finished(bb::system::SystemUiResult::Type)), this,
				SLOT(overBudgetDialogClose()));
		if (success)
			dialog->show();
		else
			dialog->deleteLater();
	}

	QStringList endDateList = endDateStr.split(".");
	//0:month 1:day 2:year
	QDate endDateObj = QDate(endDateList[2].toInt(), endDateList[0].toInt(),
			endDateList[1].toInt());
	QDate oldStartDate = endDateObj.addDays(1);
	QDate newStartDateObj = getNewStartDate(oldStartDate);
	QString newStartDateStr = newStartDateObj.toString("MM.dd.yyyy");
	QString emitStr = newStartDateObj.toString("yyyy-MM-dd");
	QStringList newStartDateList = newStartDateStr.split(".");
	QDate newStartDate = QDate(newStartDateList[2].toInt(),
			newStartDateList[0].toInt(), newStartDateList[1].toInt());
	//Set used budget = 0, updateBar, add current period to periods list, add current expenses under period, clear current list
	//addToReports();
	//clearList();

	emit periodChanged(emitStr);

	QString fixedDate = fixForConversion(periodMap["endDate"].toString());
	QString convertedDate = convertDate(fixedDate);
	QString fixedStartDate = fixForConversion(newStartDateStr);
	QString convertedStartDate = convertDate(fixedStartDate);

	//Set current period "isMain" to false
	int periodIndex = periodList.indexOf(periodMap);
	periodMap["isMain"] = "false";
	periodList.replace(periodIndex, periodMap);

	//Add new period to periodList
	periodMap["budgetUsed"] = "0";
	periodMap["startDate"] = newStartDateStr;
	periodMap["endDate"] = getNewEndDate(newStartDateObj);
	//Using start date, can change back to convertedDate if it doesn't work
	periodMap["yearRank"] = rankItemYear(convertedStartDate);
	periodMap["dayRank"] = rankItemDay(convertedStartDate);
	periodMap["monthRank"] = rankItemMonth(convertedStartDate);
	periodMap["isMain"] = "true";
	periodMap["expenses"].clear();
	periodList.insert(0, periodMap);

	_budgetStartDate = periodMap["startDate"].toString();
	_budgetEndDate = periodMap["endDate"].toString();

	addPeriodExpenses();
	savePeriods();
	//Clears previous ListView, in order to reload the ReportItems
	periodExpensesModel->clear();
	updatePeriodView();
	reloadWebView(false); //Reload the line graph WebView
	fastUpdateListView();
	updateBar();
}

QString ListTest::getNewEndDate(QDate newStartDate) {
	QString startDateStr = newStartDate.toString("MM.dd.yyyy");
	QString returnDate;
	int endDay = newStartDate.day();
	int endMonth = newStartDate.month();
	int endYear = newStartDate.year();

	// The addDays(-1) is because you are looking for the end date and that is always 1 day before the new period date
	if (_budgetType == "monthly") {
		if (endMonth == 12) {
			newStartDate.setDate(endYear + 1, 1, endDay);
			newStartDate = newStartDate.addDays(-1);
		} else {
			newStartDate.setDate(endYear, endMonth + 1, endDay);
			newStartDate = newStartDate.addDays(-1);
		}
	} else if (_budgetType == "weekly") {
		newStartDate = newStartDate.addDays(6);
	} else if (_budgetType == "biweekly") {
		newStartDate = newStartDate.addDays(13);
	} else if (_budgetType == "yearly") {
		newStartDate.setDate(endYear + 1, endMonth, endDay);
		newStartDate = newStartDate.addDays(-1);
	} else if (_budgetType == "daily") {
		//Do nothing because end day is on the same day
	}

	returnDate = newStartDate.toString("MM.dd.yyyy");

	return returnDate;
}

QString ListTest::getBudgetType(const QString &selectedAccountID) {
	if (selectedAccountID != "") {
		QVariantList tempPeriodList = jda.load(
				QDir::homePath() + QString("/user/period") + QString("_")
						+ selectedAccountID + QString(".json")).value<
				QVariantList>();
		QVariant selectedPeriod = getPeriodOf(tempPeriodList);
		QVariantMap selectedPeriodMap = selectedPeriod.toMap();
		return selectedPeriodMap["budgetType"].toString();
	} else {
		return periodMap["budgetType"].toString();
	}
}

QVariant ListTest::getPeriodOf(QVariantList selectedPeriodList) {
	QVariant returnPeriod;

	foreach (QVariant it, selectedPeriodList){
	QVariantMap selectedPeriod = it.toMap();
	if (selectedPeriod["isMain"] == "true") {
		returnPeriod = selectedPeriod;
		break;
	}
}
	return returnPeriod;
}

QDate ListTest::getNewStartDate(QDate oldStartDate) {
	QDate currentDate = QDate::currentDate();
	QString currentDateStr = currentDate.toString("MM.dd.yyyy");
	QString oldStartDateStr = oldStartDate.toString("MM.dd.yyyy");
	QString returnDate;
	int currentDay = currentDate.day();
	int currentMonth = currentDate.month();
	int currentYear = currentDate.year();
	int endDay = oldStartDate.day();
	int endMonth = oldStartDate.month();
	int daysBetween = oldStartDate.daysTo(currentDate);

	if (_budgetType == "monthly") {
		if (currentDay < endDay) {
			if (currentMonth == 1) {
				currentDate.setDate(currentYear - 1, 12, endDay);
			} else {
				currentDate.setDate(currentYear, currentMonth - 1, endDay);
			}
		} else if (currentDay > endDay) {
			currentDate.setDate(currentYear, currentMonth, endDay);
		}
	} else if (_budgetType == "weekly") {
		//Make it a negative number, because you have to use addDays and you want to subtract
		int diff = (daysBetween % 7) * (-1);
		currentDate = currentDate.addDays(diff);
	} else if (_budgetType == "yearly") {
		if (currentMonth < endMonth) {
			currentDate.setDate(currentYear - 1, endMonth, endDay);
		} else if ((currentMonth == endMonth) && (endDay > currentDay)) {
			//Go back a year
			currentDate.setDate(currentYear - 1, endMonth, endDay);
		} else {
			currentDate.setDate(currentYear, endMonth, endDay);
		}
	} else if (_budgetType == "biweekly") {
		//Make it a negative number, because you have to use addDays and you want to subtract
		int diff = (daysBetween % 14) * (-1);
		currentDate = currentDate.addDays(diff);
	} else if (_budgetType == "daily") {
		//Dont to anything, it is equal to currentDate
	}

	return currentDate;
}

QString ListTest::convertDateNum(QString dateToConvert) {
	QStringList splitDate = dateToConvert.split(" ");
	QString month = rankItemMonth(splitDate[0], true);
	QString day = splitDate[1];
	QString year = splitDate[2];

	return month + "." + day + "." + year;
}

void ListTest::addNewRecord(const QString &expenseName, QString expenseAmount,
		const QString &expenseDate, const QString &expenseCategory,
		const QString &fullDate) {

	QString convertedDate = convertDate(expenseDate);
	QString checkDate = isWithinRange(convertDateNum(convertedDate), periodMap["startDate"].toString(), periodMap["endDate"].toString());
	QVariantMap newPeriodMap = periodMap;
	bool isWithin = true;

	if (checkDate == "within") {
		//No need to change
		SystemToast *toast = new SystemToast(this);

		toast->setBody("Expense saved.");
		toast->setPosition(SystemUiPosition::MiddleCenter);
		toast->show();
	} else if (checkDate == "past") {
		SystemToast *toast = new SystemToast(this);

		toast->setBody("Cannot save expense to future period.");
		toast->setPosition(SystemUiPosition::MiddleCenter);
		toast->show();
		return;
	} else if (checkDate == "before") {
		//Need to change periodMap
		isWithin = false;
		//Empty it out
		newPeriodMap.clear();

		foreach (QVariant it, periodList) {
			QVariantMap selectedPeriodMap = it.toMap();
			if (isWithinRange(convertDateNum(convertedDate), selectedPeriodMap["startDate"].toString(), selectedPeriodMap["endDate"].toString()) == "within") {
				newPeriodMap = selectedPeriodMap;
				break;
			}

		}
		if (!newPeriodMap.isEmpty()) {

			SystemToast *toast = new SystemToast(this);

			toast->setBody("Saving expense in previous period.");
			toast->setPosition(SystemUiPosition::MiddleCenter);
			toast->show();
		} else {
			SystemToast *toast = new SystemToast(this);

			toast->setBody("Cannot save expense that far into the past.");
			toast->setPosition(SystemUiPosition::MiddleCenter);
			toast->show();
			return;
		}
	}
	QVariantList innerExpenseList = newPeriodMap["expenses"].toList();
	int periodIndex = periodList.indexOf(newPeriodMap);
	//Modify expense
	//Convert to float for the .00
	expenseAmount.remove("$");
	expenseAmount.remove(",");

	// Create QVariantMap
	QVariantMap expenseMap;

	// Populate each object with data
	expenseMap["accountID"] = accountMap["accountID"].toString();
	expenseMap["secondRank"] = rankItemSecond(fullDate);
	expenseMap["minuteRank"] = rankItemMinute(fullDate);
	expenseMap["hourRank"] = rankItemHour(fullDate);
	expenseMap["yearRank"] = rankItemYear(convertedDate);
	expenseMap["dayRank"] = rankItemDay(convertedDate);
	expenseMap["monthRank"] = rankItemMonth(convertedDate);
	expenseMap["key"] = expenseList.count();
	expenseMap["title"] = expenseName;
	expenseMap["amount"] = expenseAmount;
	expenseMap["dated"] = convertedDate; //Format: January 1 2013
	expenseMap["icon"] = expenseCategory;
	//Save in global expenses
	expenseList.insert(0, expenseMap);
	//Save in inner expenses
	innerExpenseList.insert(0, expenseMap);
	//Add to previous expenses if necessary
	if (addToPreviousPeriod(expenseMap)) {
		qDebug() << "Added expense to a previous period";
	} else {
		qDebug() << "Expense was not needed to be added to previous period";
	}

	//Modify budget in accountList
	float newAmount = newPeriodMap["budgetUsed"].toFloat() + expenseAmount.toFloat();
	QString qNewAmount;
	qNewAmount.sprintf("%.2f", newAmount);

	//Only do this if its a current expense
	if (isWithin) {
		//If expense is added to another period, this may cause problems
		newPeriodMap["isMain"] = "true";
	}
	//Modify current period
	newPeriodMap["budgetUsed"] = qNewAmount;
	//Insert innerExpenseList into expense variable of current period
	newPeriodMap["expenses"] = innerExpenseList;

	//Check if any periods have been saved
	if (periodList.count() > 0) {
		periodList.replace(periodIndex, newPeriodMap);
	} else {
		periodList.insert(0, newPeriodMap);
	}
	saveJson();
	updatePeriodView();
	reloadWebView(true); // You should probably replace all emit update graphs with this, the load time is about the same, this might even be a little faster
	fastUpdateListView();
	updateBar();
}

void ListTest::fastUpdateListView() {
	expenseList = jda.load( QDir::homePath() + QString("/user/expenses") + QString("_")
									+ accountMap["accountID"].toString()
									+ QString(".json")).value<QVariantList>();
	expenseModel->clear();
	expenseModel->insertList(periodMap["expenses"].toList());
}

void ListTest::updateListView() {
	expenseList = jda.load( QDir::homePath() + QString("/user/expenses") + QString("_")
								+ accountMap["accountID"].toString()
								+ QString(".json")).value<QVariantList>();

	expenseModel->clear();
	expenseModel->insertList(expenseList);
}

void ListTest::updatePeriodExpensesListView(const QString &date1,
		const QString &date2) {
	QVariant returnPeriod;

	foreach (QVariant it, periodList){
		QVariantMap selectedPeriod = it.toMap();
		if ((selectedPeriod["startDate"].toString() == date1) && (selectedPeriod["endDate"].toString() == date2)) {
			returnPeriod = selectedPeriod;
			break;
		}
	}
	QVariantList periodExpenseList = returnPeriod.toMap()["expenses"].toList();

	periodExpensesListView = tabbedPane->findChild<ListView*>(
			"periodExpensesListView");
	periodExpensesListView->setDataModel(periodExpensesModel);
	periodExpensesModel->clear();
	periodExpensesModel->insertList(periodExpenseList);
}

bool ListTest::addToPreviousPeriod(QVariantMap expenseMap) {
	bool foundPeriod = false;

	foreach (QVariant it, periodList) {
		QVariantMap selectedPeriodMap = it.toMap();
		if (selectedPeriodMap == periodMap) continue; // Skip the selected period, since its already done in the caller function
		if (isWithinRange(convertDateNum(expenseMap["dated"].toString()), selectedPeriodMap["startDate"].toString(), selectedPeriodMap["endDate"].toString()) == "within") {
			foundPeriod = true;
			int periodIndex = periodList.indexOf(selectedPeriodMap);
			QVariantList innerExpenseList = selectedPeriodMap["expenses"].toList();
			innerExpenseList.insert(0, expenseMap);
			selectedPeriodMap["expenses"] = innerExpenseList;
			periodList.replace(periodIndex, selectedPeriodMap);
		}
	}

	return foundPeriod;
}

void ListTest::addPeriodExpenses() {
	QVariantList filteredList;

	foreach (QVariant it, expenseList) {
		QVariantMap selectedExpense = it.toMap();
		if (isWithinRange(convertDateNum(selectedExpense["dated"].toString()), periodMap["startDate"].toString(), periodMap["endDate"].toString()) == "within") {
			QVariantList expenseList = periodMap["expenses"].toList();
			filteredList.insert(0, selectedExpense);
			//foundExpense = true;
		}
	}

	int periodIndex = periodList.indexOf(periodMap);
	periodMap["expenses"] = filteredList;
	periodList.replace(periodIndex,periodMap);
}

bool ListTest::removeFromPreviousPeriod(QVariantMap expenseMap) {
	bool foundPeriod = false;

	foreach (QVariant it, periodList) {
		QVariantMap selectedPeriodMap = it.toMap();
		if (selectedPeriodMap == periodMap) continue; // Skip the selected period, since its already done in the caller function
		if (isWithinRange(convertDateNum(expenseMap["dated"].toString()), selectedPeriodMap["startDate"].toString(), selectedPeriodMap["endDate"].toString()) == "within") {
			foundPeriod = true;
			int periodIndex = periodList.indexOf(selectedPeriodMap);
			QVariantList innerExpenseList = selectedPeriodMap["expenses"].toList();
			int expenseIndex = innerExpenseList.indexOf(expenseMap);
			innerExpenseList.removeAt(expenseIndex);
			selectedPeriodMap["expenses"] = innerExpenseList;
			periodList.replace(periodIndex, selectedPeriodMap);
		}
	}

	return foundPeriod;
}

void ListTest::updatePeriodView() {
	periodList =
			jda.load(
					QDir::homePath() + QString("/user/period") + QString("_")
							+ accountMap["accountID"].toString()
							+ QString(".json")).value<QVariantList>();

	//Set the periods QVariantMap
	QVariant primaryPeriod = getPrimaryPeriod();
	periodMap = primaryPeriod.toMap();

	periodModel->clear();
	periodModel->insertList(periodList);
}

void ListTest::updateAccountView() {
	accountModel->clear();
	accountModel->insertList(accountList);
}

void ListTest::reloadWebView(bool shouldClear) {
	emit reloadWeb();
}

void ListTest::updateSelectedRecord(const QVariant &selectedItem, QString expenseAmount,
		const QString &expenseName, const QString &expenseDate,
		const QString &expenseCategory) {
	QString convertedDate = convertDate(expenseDate);
	expenseAmount.remove("$");
	expenseAmount.remove(",");
	QVariantMap expenseMap = selectedItem.toMap();
	int itemDataIndex = expenseList.indexOf(expenseMap);
	int periodIndex = periodList.indexOf(periodMap);
	float previousAmount = expenseMap["amount"].toFloat();

	expenseMap["yearRank"] = rankItemYear(convertedDate);
	expenseMap["dayRank"] = rankItemDay(convertedDate);
	expenseMap["monthRank"] = rankItemMonth(convertedDate);
	expenseMap["title"] = expenseName;
	expenseMap["amount"] = expenseAmount;
	expenseMap["dated"] = convertedDate;
	expenseMap["icon"] = expenseCategory;

	//Replace current expense in expenseList to updated expense
	expenseList.replace(itemDataIndex, expenseMap);

	float newAmount = periodMap["budgetUsed"].toFloat()
			+ (expenseAmount.toFloat() - previousAmount);
	QString qNewAmount;
	qNewAmount.sprintf("%.2f", newAmount);
	periodMap["budgetUsed"] = qNewAmount;
	periodMap["expenses"] = expenseList;

	//Replace current expenseList in periodList to updated expenseList
	periodList.replace(periodIndex, periodMap);

	saveJson();
	updateListView();
	updatePeriodView();
	updateBar();
	//Update line graph signal
	emit updateGraph(periodMap);
}
/*
void ListTest::updateSumAmount(const QString &keyPressed, const QString &fromPage) {
	QString previousAmount = budgetField->text();
	qDebug() << "previousAmount: " + previousAmount;
	previousAmount.remove(",");
	float currentAmount = amountText;
	float addingDigit = (keyPressed.toFloat()) / 100; //Converted to a .0X

	//Move digit
	currentAmount *= 10;
	//Add digit in end
	currentAmount += addingDigit;
	float numberTruncated = (int)(currentAmount * 100) / 100.0;
	qDebug() << "trunc: " + Float.toString(numberTruncated);
	amountText = QString::number(numberTruncated, 'f', 2);
	//amountText = QLocale(QLocale::English).toString(amountText.toFloat());
	qDebug() << "amountText: " + amountText;

	if (fromPage == "addPage") {
		amountLabel->setText("$" + amountText);
	} else if (fromPage == "editPage") {
		amountLabelEdit->setText("$" + amountText);
	} else if (fromPage == "budgetPage") {
		budgetField->setText("$" + amountText);
	}
}
*/

QString ListTest::addDigitToValue(QString fullValue, QString digit) {
	qDebug() << "Before adding: " + fullValue;
	fullValue.remove(",");
	fullValue.remove(".");
	fullValue.remove("$");

	//Add digit
	fullValue.push_back(digit);
	//If it starts with zero, remove it. (Simulates shifting the added number over)
	if (fullValue.startsWith('0')) {
		fullValue.remove(0,1);
	}
	addComma(fullValue);
	/*
	if (fullValue.length() > 5) {
		int digitsLeftOfDecimal = fullValue.length()-2;
		int numOfComma = floor(digitsLeftOfDecimal/4);
		qDebug() << "numberofcommas: " + QString::number(numOfComma);
		for (int x = 0; x<numOfComma; x++) {
			//Algorithm for inserting commas
			fullValue.insert((fullValue.length()-2) - (3*(x+1)) + x,",");
		}
	}
	*/

	fullValue.insert(fullValue.length()-2,'.');
	fullValue.insert(0,'$');

	return fullValue;
}

QString ListTest::deleteDigitFromValue(QString fullValue) {
	fullValue.remove(",");
	fullValue.remove(".");
	fullValue.remove("$");

	//Remove last digit
	fullValue.remove(fullValue.length()-1,1);
	if ((fullValue.length() < 3) || fullValue.startsWith('0')) {
		fullValue.insert(0,'0');
	}
	addComma(fullValue);
	/*
		int digitsLeftOfDecimal = fullValue.length()-2;
		int numOfComma = floor(digitsLeftOfDecimal/4);
		qDebug() << "numberofcommas: " + QString::number(numOfComma);
		for (int x = 0; x<numOfComma; x++) {
			//Algorithm for inserting commas
			fullValue.insert((fullValue.length()-2) - (3*(x+1)) + x,",");
		}
	*/

	fullValue.insert(fullValue.length()-2,'.');
	fullValue.insert(0,'$');

	return fullValue;
}

QString ListTest::addComma(QString &num) {
	num.remove(",");
	num.remove(".");
	num.remove("$");

	QString commaSection = num;
	commaSection.remove(commaSection.length()-2,2);

	while (commaSection.length() > 3) {
		num.insert(commaSection.length() - 3, ',');
		commaSection = (num.split(','))[0];
	}

	return num;
}

void ListTest::updateSumAmount(const QString &keyPressed,
		const QString &fromPage) {
	//QString labelValue = addDigitToValue(budgetField.text, keyPressed);

	/*
	amountText.remove(",");
	float currentAmount = amountText.toFloat();
	float addingDigit = (keyPressed.toFloat()) / 100; //Converted to a .0X

	//Move digit
	currentAmount *= 10;
	//Add digit in end
	currentAmount += addingDigit;
	//float numberTruncated = (int)(currentAmount * 100) / 100.0;
	//qDebug() << "trunc: " + Float.toString(numberTruncated);
	amountText = QString::number(currentAmount, 'f', 2);
	//amountText = QLocale(QLocale::English).toString(currentAmount);
	qDebug() << "amountText: " + amountText;
	*/

	if (fromPage == "addPage") {
		amountLabel->setText("$");
	} else if (fromPage == "editPage") {
		amountLabelEdit->setText("$");
	} else if (fromPage == "budgetPage") {
		budgetField->setText("$");
	}
}

void ListTest::getCreateLabel() {
	createLabel = tabbedPane->findChild<Label*>("createLabel");
}

void ListTest::getVerifyLabel() {
	verifyLabel = tabbedPane->findChild<Label*>("verifyLabel");
}

void ListTest::updatePinSumAmount(const QString &keyPressed,
		const QString &fromPage) {
	amountText += keyPressed;
	if (fromPage == "createLock") {
		createLabel->setText(amountText);
	} else if (fromPage == "verifyLock") {
		verifyLabel->setText(amountText);
	}
}

bool ListTest::hasPin() {
	QSettings settings("Salehisource", "SnapBudget");

	return settings.contains("pin");
}

// Might want to change name to deleteSumAmount, this doesn't do anything for saving..
void ListTest::updateSumAmountSymbol(const QString &keyPressed,
		const QString &fromPage) {
	if (keyPressed != "Save") {
		amountText.remove(",");
		if (amountText != "0.00") {
			amountText.replace(amountText.length() - 1, 1, '0');
			float currentAmount = amountText.toFloat();
			currentAmount = currentAmount / 10;
			amountText = QString::number(currentAmount, 'f', 2);
		}
		if (fromPage == "addPage") {
			amountLabel->setText("$" + amountText);
		} else if (fromPage == "editPage") {
			amountLabelEdit->setText("$" + amountText);
		} else if (fromPage == "budgetPage") {
			budgetField->setText("$" + amountText);
		}
	}
}

void ListTest::deletePinAmount(const QString &fromPage) {
	if (amountText != "") {
		amountText.replace(amountText.length() - 1, 1, "");
	}
	if (fromPage == "createLock") {
		createLabel->setText(amountText);
	} else if (fromPage == "verifyLock") {
		verifyLabel->setText(amountText);
	}
}

void ListTest::clearAmountText() {
	amountText = "0.00";
	amountLabel->setText("$" + amountText);
}

void ListTest::clearEditAmountText() {
	amountText = "0.00";
	amountLabelEdit->setText("$" + amountText);
}

void ListTest::clearBudgetAmount() {
	amountText = "0.00";
	budgetField->setText("$" + amountText);
}

void ListTest::editAmountText(const QString &currentAmount) {
	editPage = tabbedPane->findChild<Page*>("editPage");
	amountLabelEdit = tabbedPane->findChild<Label*>("amountLabelEdit");
	//amountText = currentAmount;
	amountLabelEdit->setText("$" + currentAmount);
}

void ListTest::fillBudgetPage() {
	budgetField = tabbedPane->findChild<TextField*>("budgetField");
	//clearBudgetAmount();
}

void ListTest::fillAddAccount() {
	budgetField = tabbedPane->findChild<TextField*>("budgetField");
}

void ListTest::createAccount(const QString &accountName,
		const QString &expenseAmount, const QString &budgetType,
		const QString &startDate, const QString &endDate) {
	saveAccount(accountName, true);
	setBudget(expenseAmount, budgetType, startDate, endDate, true);
}

QVariant ListTest::saveAccount(const QString &accountNameField,
		bool firstTime) {
	accountList =
			jda.load(QDir::homePath() + QString("/user/accountinfo.json")).value<
					QVariantList>();

	if (accountList.empty()) {
		incrementingAccountID = "0";
		accountMap["accountID"] = getIncrementedID();
		accountMap["accountName"] = accountNameField;
		accountMap["isMain"] = "true";
		accountMap["currency"] = "USD";
		accountMap["budgetSet"] = "false";
	} else {
		accountMap["accountID"] = getIncrementedID();
		accountMap["accountName"] = accountNameField;
		accountMap["isMain"] = "false";
		accountMap["currency"] = "USD";
		accountMap["budgetSet"] = "false";
	}
	accountList.insert(0, accountMap);

	QVariant returnAccount = accountMap;

	//Save empty list for account
	QVariantList emptyList;
	jda.save(emptyList,
			QDir::homePath() + QString("/user/period") + QString("_")
					+ accountMap["accountID"].toString() + QString(".json"));
	jda.save(emptyList,
				QDir::homePath() + QString("/user/expenses") + QString("_")
						+ accountMap["accountID"].toString() + QString(".json"));

	saveAccountJson();
	if (!firstTime) {
		updateAccountView();
	}

	return returnAccount;
}

void ListTest::updateBar() {

	if (!(periodMap["budgetAmount"].toFloat() > 0)) {
		spentLabel->setVisible(false);
		remainingLabel->setVisible(false);
		expenseBar->setVisible(false);
		createBudgetLabel->setVisible(true);
	} else {
		spentLabel->setVisible(true);
		remainingLabel->setVisible(true);
		expenseBar->setVisible(true);
		createBudgetLabel->setVisible(false);

		float usedBudget = periodMap["budgetUsed"].toFloat();
		float totalBudget = periodMap["budgetAmount"].toFloat();
		float remainingBudget = totalBudget - usedBudget;
		float percentNum = ((usedBudget / totalBudget) * 100);

		QString usedBudgetS;
		usedBudgetS.sprintf("%.02f", usedBudget);
		QString remainingBudgetS;
		remainingBudgetS.sprintf("%.02f", remainingBudget);
		//Add commas
		addComma(usedBudgetS);
		addComma(remainingBudgetS);
		//Add decimals
		usedBudgetS.insert(usedBudgetS.length()-2,'.');
		remainingBudgetS.insert(remainingBudgetS.length()-2,'.');
		spentLabel->setText("$" + usedBudgetS);
		remainingLabel->setText("$" + remainingBudgetS);

		float barDistance = (((655 * usedBudget) / totalBudget) - 721);

		QString totalBudgetS;
		totalBudgetS.sprintf("%.02f", totalBudget);
		QString percentageS;
		percentageS.sprintf("%.02f", ((usedBudget / totalBudget) * 100));

		if (percentNum <= 0) {
			expenseBarLayout->setPositionX(-721);
		} else if (percentNum >= 100) {
			expenseBarLayout->setPositionX(-66);
			//Display notification to user
			float usedAmount = periodMap["budgetUsed"].toFloat();
			float totalAmount = periodMap["budgetAmount"].toFloat();
			float difference = totalAmount - usedAmount;
			QString differenceStr;
			differenceStr.sprintf("%.02f", difference);
			dialog = new SystemDialog("Close");
			dialog->setTitle("Slow Down your spendings!");
			dialog->setBody(
					"Amount over budget: $"
							+ QString::number((-1) * differenceStr.toFloat())
							+ "\n\nTry to limit your spendings until the end of this period.");

			bool success = connect(dialog,
					SIGNAL(finished(bb::system::SystemUiResult::Type)), this,
					SLOT(overBudgetDialogClose()));
			if (success)
				dialog->show();
			else
				dialog->deleteLater();
		} else {
			expenseBarLayout->setPositionX(barDistance);
		}

		if (percentNum < 60) {
			expenseBar->setImage("asset:///images/newbar/greenerBar.png");
			remainingLabel->textStyle()->setColor(Color::fromARGB(0xff009621));
		} else if (percentNum >= 60 && percentNum < 90) {
			expenseBar->setImage("asset:///images/newbar/orangeBar.png");
			remainingLabel->textStyle()->setColor(Color::fromARGB(0xff9d5d02));
		} else if (percentNum >= 90) {
			expenseBar->setImage("asset:///images/newbar/redBar.png");
			remainingLabel->textStyle()->setColor(Color::fromARGB(0xff960000));
		}
	}
}

void ListTest::overBudgetDialogClose() {
}

QString ListTest::toNumDate(const QString &prevDate) {
	QString returnDate;
	QStringList dateArray = prevDate.split(" ");

	returnDate = rankItemMonth(dateArray[0], true) + "." + dateArray[1] + "."
			+ dateArray[2];
	return returnDate;
}

QString ListTest::rankItemMonth(const QString &prevDate, bool withZero,
		QString token) {
	QString returnDate;
	QStringList dateArray = prevDate.split(token);

	if (dateArray[0] == "January")
		if (!withZero)
			returnDate = "1";
		else
			returnDate = "01";
	else if (dateArray[0] == "February")
		if (!withZero)
			returnDate = "2";
		else
			returnDate = "02";
	else if (dateArray[0] == "March")
		if (!withZero)
			returnDate = "3";
		else
			returnDate = "03";
	else if (dateArray[0] == "April")
		if (!withZero)
			returnDate = "4";
		else
			returnDate = "04";
	else if (dateArray[0] == "May")
		if (!withZero)
			returnDate = "5";
		else
			returnDate = "05";
	else if (dateArray[0] == "June")
		if (!withZero)
			returnDate = "6";
		else
			returnDate = "06";
	else if (dateArray[0] == "July")
		if (!withZero)
			returnDate = "7";
		else
			returnDate = "07";
	else if (dateArray[0] == "August")
		if (!withZero)
			returnDate = "8";
		else
			returnDate = "08";
	else if (dateArray[0] == "September")
		if (!withZero)
			returnDate = "9";
		else
			returnDate = "09";
	else if (dateArray[0] == "October")
		returnDate = "10";
	else if (dateArray[0] == "November")
		returnDate = "11";
	else if (dateArray[0] == "December")
		returnDate = "12";

	return returnDate;
}

QString ListTest::rankItemDay(const QString &prevDate, QString token) {
	QString returnDate;
	QStringList dateArray = prevDate.split(token);
	returnDate = dateArray[1];

	return returnDate;
}

QString ListTest::rankItemYear(const QString &prevDate, QString token) {
	QString returnDate;
	QStringList dateArray = prevDate.split(token);
	returnDate = dateArray[2];

	return returnDate;
}

QString ListTest::rankItemHour(const QString &prevDate, QString token) {
	QString returnDate;
	QStringList tempDate;
	QStringList dateArray = prevDate.split(token);
	tempDate = dateArray[4].split(":");
	returnDate = tempDate[0];

	return returnDate;
}

QString ListTest::rankItemMinute(const QString &prevDate, QString token) {
	QString returnDate;
	QStringList tempDate;
	QStringList dateArray = prevDate.split(token);
	tempDate = dateArray[4].split(":");
	returnDate = tempDate[1];

	return returnDate;
}

QString ListTest::rankItemSecond(const QString &prevDate, QString token) {
	QString returnDate;
	QStringList tempDate;
	QStringList dateArray = prevDate.split(token);
	tempDate = dateArray[4].split(":");
	returnDate = tempDate[2];

	return returnDate;
}

QString ListTest::fixForConversion(const QString &changeDate) {
	QString returnString = "";
	QStringList dateArray = changeDate.split(".");

	if (dateArray[0] == "01")
		dateArray[0] = "Jan";
	else if (dateArray[0] == "02")
		dateArray[0] = "Feb";
	else if (dateArray[0] == "03")
		dateArray[0] = "Mar";
	else if (dateArray[0] == "04")
		dateArray[0] = "Apr";
	else if (dateArray[0] == "05")
		dateArray[0] = "May";
	else if (dateArray[0] == "06")
		dateArray[0] = "Jun";
	else if (dateArray[0] == "07")
		dateArray[0] = "Jul";
	else if (dateArray[0] == "08")
		dateArray[0] = "Aug";
	else if (dateArray[0] == "09")
		dateArray[0] = "Sep";
	else if (dateArray[0] == "10")
		dateArray[0] = "Oct";
	else if (dateArray[0] == "11")
		dateArray[0] = "Nov";
	else if (dateArray[0] == "12")
		dateArray[0] = "Dec";

	//The placeholder is because convertDate ignores the first element in the QStringList
	return QString("placeholder") + " " + dateArray[0] + " " + dateArray[1]
			+ " " + dateArray[2];
}

QString ListTest::convertDate(const QString &prevDate) {
	QString returnString = "";
	QStringList dateArray = prevDate.split(" ");

	if (dateArray[1] == "Jan")
		dateArray[1] = "January";
	else if (dateArray[1] == "Feb")
		dateArray[1] = "February";
	else if (dateArray[1] == "Mar")
		dateArray[1] = "March";
	else if (dateArray[1] == "Apr")
		dateArray[1] = "April";
	else if (dateArray[1] == "Jun")
		dateArray[1] = "June";
	else if (dateArray[1] == "Jul")
		dateArray[1] = "July";
	else if (dateArray[1] == "Aug")
		dateArray[1] = "August";
	else if (dateArray[1] == "Sep")
		dateArray[1] = "September";
	else if (dateArray[1] == "Oct")
		dateArray[1] = "October";
	else if (dateArray[1] == "Nov")
		dateArray[1] = "November";
	else if (dateArray[1] == "Dec")
		dateArray[1] = "December";

	returnString = dateArray[1] + " " + dateArray[2] + " " + dateArray[3];

	return returnString;

}

void ListTest::setUpAccountModel() {
	expenseBarLayout = expenseBar->findChild<AbsoluteLayoutProperties*>(
			"expenseBarLayout");
	QFile file(QDir::homePath() + QString("/user/accountinfo.json"));
	if (file.exists()) {
		accountList = jda.load(
				QDir::homePath() + QString("/user/accountinfo.json")).value<
				QVariantList>();
	} else {
		QDir dir;
		dir.mkpath(QDir::homePath() + QString("/user"));
	}

	if (accountList.empty()) {
		incrementingAccountID = "0";
		accountMap["accountID"] = getIncrementedID();
		accountMap["accountName"] = "Standard Account";
		accountMap["isMain"] = "true";
		accountMap["currency"] = "USD";

		accountList.insert(0, accountMap);
		saveAccountJson();
		saveJson();

		//Set primary account
		primaryAccount = getPrimaryAccount();
	} else {
		//Check which one is the main account
		primaryAccount = getPrimaryAccount();
		//Get incrementingAccountID
		incrementingAccountID = getIncrementingAccountID();
		//Set the primary map
		accountMap = primaryAccount.toMap();
	}
}

QString ListTest::getIncrementingAccountID() {
	QString returnString;
	QVariant lastAccount;
	QVariantMap lastMap;

	lastAccount = accountList.first();
	lastMap = lastAccount.toMap();
	returnString = lastMap["accountID"].toString();

	return returnString;
}

QVariant ListTest::getPrimaryAccount() {
	QVariant returnAccount;

	foreach (QVariant it, accountList){
	QVariantMap selectedAccount = it.toMap();
	if (selectedAccount["isMain"] == "true") {
		returnAccount = selectedAccount;
		break;
	}
}
	return returnAccount;
}

QString ListTest::isWithinRange(QString checkDate, QString startDate,
		QString endDate) {
	QString isWithin;
	QStringList date1List = startDate.split(".");
	QStringList date2List = endDate.split(".");
	QStringList checkDateList = checkDate.split(".");
	int date1Month = date1List[0].toInt();
	int date2Month = date2List[0].toInt();
	int checkDateMonth = checkDateList[0].toInt();
	int date1Day = date1List[1].toInt();
	int date2Day = date2List[1].toInt();
	int checkDateDay = checkDateList[1].toInt();
	int date1Year = date1List[2].toInt();
	int date2Year = date2List[2].toInt();
	int checkDateYear = checkDateList[2].toInt();
	QDate date1 = QDate(date1Year, date1Month, date1Day);
	QDate date2 = QDate(date2Year, date2Month, date2Day);
	QDate cDate = QDate(checkDateYear, checkDateMonth, checkDateDay);

	if (cDate.daysTo(date2) >= 0 && cDate.daysTo(date1) <= 0) {
		isWithin = "within";
	} else if (cDate.daysTo(date2) < 0) {
		isWithin = "past";
	} else if (cDate.daysTo(date1) > 0) {
		isWithin = "before";
	}
	return isWithin;
}

QString ListTest::getIncrementedID() {
	QString prevID = incrementingAccountID;
	int intID;
	prevID.replace("#", "");
	intID = prevID.toInt();
	intID++;
	incrementingAccountID = "#" + QString::number(intID) + "#";
	return incrementingAccountID;
}

void ListTest::setUpAccountListModel() {
	accountPage = tabbedPane->findChild<Page*>("accountPage");
	accountListView = accountPage->findChild<ListView*>("accountListView");

	QStringList sortingKey;
	sortingKey << "isMain" << "accountID" << "accountName" << "accountBudget";

	accountModel = new GroupDataModel();
	accountModel->setParent(this);
	accountModel->insertList(accountList);
	accountModel->setGrouping(ItemGrouping::None);
	accountModel->setSortingKeys(sortingKey);
	accountModel->setSortedAscending(false);
	accountListView->resetDataModel();
	accountListView->setDataModel(accountModel);
}

<<<<<<< HEAD
=======
void ListTest::removeExcessPeriod(QVariant excessPeriod) {
	qDebug() << "Running remove excess period";
	int excessPeriodIndex = periodList.indexOf(excessPeriod);
	qDebug() << "excessPeriodIndex: " + QString::number(excessPeriodIndex);
	periodList.removeAt(excessPeriodIndex);

	//Do you need a replace here??

	savePeriods();
	updatePeriodView();
	//Test variables
	qDebug() << "PeriodMap[endDate]:" + periodMap["endDate"].toString();
	qDebug() << "PeriodList count:" + QString::number(periodList.count());
	emit updateGraph(periodMap);
	qDebug() << "Period removed from JSON periodList";
}

>>>>>>> e2b994cd1929a8b2ef4f57d3693821e7a32bb83e
void ListTest::setUpPeriodListModel() {
	QStringList sortingKey;
	sortingKey << "isMain" << "yearRank" << "monthRank" << "dayRank";
	periodList = jda.load(QDir::homePath() + QString("/user/period") + QString("_")
					+ accountMap["accountID"].toString()
					+ QString(".json")).value<QVariantList>();
	expenseList = jda.load(QDir::homePath() + QString("/user/expenses") + QString("_")
					+ accountMap["accountID"].toString()
					+ QString(".json")).value<QVariantList>();

	if (jda.hasError()) {
		bb::data::DataAccessError error = jda.error();
		qDebug() << "JSON loading error: " << error.errorType() << ": "
				<< error.errorMessage();
		return;
	}

	periodListView = tabbedPane->findChild<ListView*>("periodListView");
	periodModel = tabbedPane->findChild<GroupDataModel*>("reportModel");

	//Set the periods QVariantMap
	QVariant primaryPeriod = getPrimaryPeriod();
	periodMap = primaryPeriod.toMap();
	_budgetType = periodMap["budgetType"].toString();
	_budgetStartDate = periodMap["startDate"].toString();
	_budgetEndDate = periodMap["endDate"].toString();

	//periodModel = new GroupDataModel();
	periodModel->setParent(this);
	periodModel->insertList(periodList); // periodMap["expenses"].toList()
	periodModel->setGrouping(ItemGrouping::None);
	periodModel->setSortingKeys(sortingKey);
	periodModel->setSortedAscending(false);
	periodListView->setDataModel(periodModel);
}

QVariant ListTest::getPrimaryPeriod() {
	QVariant returnPeriod;

	foreach (QVariant it, periodList){
		QVariantMap selectedPeriod = it.toMap();
		if (selectedPeriod["isMain"] == "true") {
			returnPeriod = selectedPeriod;
			break;
		}
	}
	return returnPeriod;
}

void ListTest::setUpExpenseListModel() {
	QStringList sortingKey;
	sortingKey << "yearRank" << "monthRank" << "dayRank" << "hourRank"
			<< "minuteRank" << "secondRank";
	expenseList = periodMap["expenses"].toList();

	expenseModel = new GroupDataModel();
	expenseModel->setParent(this);
	expenseModel->insertList(expenseList);
	expenseModel->setGrouping(ItemGrouping::None);
	expenseModel->setSortingKeys(sortingKey);
	expenseModel->setSortedAscending(false);
	expenseListView->setDataModel(expenseModel);
}

void ListTest::setUpPeriodExpensesListModel() {
	QStringList sortingKey;
	sortingKey << "yearRank" << "monthRank" << "dayRank" << "hourRank"
			<< "minuteRank" << "secondRank";

	periodExpensesModel = new GroupDataModel();
	periodExpensesModel->setParent(this);
	periodExpensesModel->setGrouping(ItemGrouping::None);
	periodExpensesModel->setSortingKeys(sortingKey);
	periodExpensesModel->setSortedAscending(false);
}
