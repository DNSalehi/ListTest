/****************************************************************************
** Meta object code from reading C++ file 'ListTest.hpp'
**
** Created by: The Qt Meta Object Compiler version 63 (Qt 4.8.5)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../src/ListTest.hpp"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'ListTest.hpp' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 63
#error "This file was generated using the moc from 4.8.5. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_ListTest[] = {

 // content:
       6,       // revision
       0,       // classname
       0,    0, // classinfo
      54,   14, // methods
       2,  284, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       6,       // signalCount

 // signals: signature, parameters, type, tag, flags
      10,    9,    9,    9, 0x05,
      33,    9,    9,    9, 0x05,
      55,    9,    9,    9, 0x05,
      73,    9,    9,    9, 0x05,
      85,    9,    9,    9, 0x05,
     104,    9,    9,    9, 0x05,

 // slots: signature, parameters, type, tag, flags
     126,    9,    9,    9, 0x0a,
     138,    9,    9,    9, 0x0a,

 // methods: signature, parameters, type, tag, flags
     225,  162,    9,    9, 0x02,
     347,  279,    9,    9, 0x02,
     426,  410,    9,    9, 0x02,
     507,  454,    9,    9, 0x02,
     598,  555,    9,    9, 0x22,
     696,  641,    9,    9, 0x02,
     751,  641,    9,    9, 0x02,
     819,  803,    9,    9, 0x02,
     860,  840,    9,    9, 0x02,
     893,  840,    9,    9, 0x02,
     929,    9,    9,    9, 0x02,
     939,    9,    9,    9, 0x02,
     957,    9,    9,    9, 0x02,
     979,    9,    9,    9, 0x02,
     999,  840,    9,    9, 0x02,
    1052, 1038,    9,    9, 0x02,
    1076,    9,    9,    9, 0x02,
    1097, 1088,    9,    9, 0x02,
    1122,    9,    9,    9, 0x02,
    1139,    9,    9,    9, 0x02,
    1161, 1156,    9,    9, 0x02,
    1178,    9,    9,    9, 0x02,
    1195,    9,    9,    9, 0x02,
    1231, 1212,    9,    9, 0x02,
    1291, 1266,    9,    9, 0x02,
    1329, 1318,    9,    9, 0x02,
    1360, 1348,    9,    9, 0x02,
    1406,    9,    9,    9, 0x02,
    1428,    9,    9,    9, 0x02,
    1444,    9,    9,    9, 0x02,
    1456,    9,    9,    9, 0x02,
    1480,    9,    9,    9, 0x02,
    1497,    9, 1492,    9, 0x02,
    1516, 1512, 1492,    9, 0x02,
    1535,    9, 1492,    9, 0x02,
    1544,    9, 1492,    9, 0x02,
    1570,    9, 1562,    9, 0x02,
    1605, 1587, 1562,    9, 0x02,
    1631,    9, 1562,    9, 0x22,
    1650, 1587, 1562,    9, 0x02,
    1673,    9, 1562,    9, 0x22,
    1689, 1587, 1562,    9, 0x02,
    1712,    9, 1562,    9, 0x22,
    1744, 1728, 1562,    9, 0x02,
    1787, 1777, 1562,    9, 0x02,
    1830,    9, 1817,    9, 0x02,

 // properties: name, type, flags
    1846, 1562, 0x0a095001,
    1857, 1562, 0x0a095001,

       0        // eod
};

static const char qt_meta_stringdata_ListTest[] = {
    "ListTest\0\0periodChanged(QString)\0"
    "updateGraph(QVariant)\0setAccountGraph()\0"
    "reloadWeb()\0emptyExpenseList()\0"
    "notEmptyExpenseList()\0checkDate()\0"
    "overBudgetDialogClose()\0"
    "expenseName,expenseAmount,expenseDate,expenseCategory,fullDate\0"
    "addNewRecord(QString,QString,QString,QString,QString)\0"
    "selectedIndex,expenseAmount,expenseName,expenseDate,expenseCategory\0"
    "updateSelectedRecord(QVariant,QString,QString,QString,QString)\0"
    "selectedExpense\0deleteItemAtIndex(QVariant)\0"
    "expenseAmount,budgetType,startDate,endDate,firstTime\0"
    "setBudget(QString,QString,QString,QString,bool)\0"
    "expenseAmount,budgetType,startDate,endDate\0"
    "setBudget(QString,QString,QString,QString)\0"
    "accountName,expenseAmount,budgetType,startDate,endDate\0"
    "createAccount(QString,QString,QString,QString,QString)\0"
    "addAccount(QString,QString,QString,QString,QString)\0"
    "selectedAccount\0setAccount(QVariant)\0"
    "keyPressed,fromPage\0"
    "updateSumAmount(QString,QString)\0"
    "updatePinSumAmount(QString,QString)\0"
    "onStart()\0clearAmountText()\0"
    "clearEditAmountText()\0clearBudgetAmount()\0"
    "updateSumAmountSymbol(QString,QString)\0"
    "currentAmount\0editAmountText(QString)\0"
    "createPin()\0fromPage\0deletePinAmount(QString)\0"
    "getCreateLabel()\0getVerifyLabel()\0"
    "lock\0lockApp(QString)\0fillBudgetPage()\0"
    "fillAddAccount()\0previousID,newName\0"
    "changeAccountName(QString,QString)\0"
    "previousID,selectedIndex\0"
    "deleteAccount(QString,int)\0endDateStr\0"
    "newPeriod(QString)\0date1,date2\0"
    "updatePeriodExpensesListView(QString,QString)\0"
    "loadAccountCreation()\0reloadWebView()\0"
    "sendEmail()\0setUpAccountListModel()\0"
    "updateBar()\0bool\0loadQMLScene()\0pin\0"
    "verifyPin(QString)\0hasPin()\0"
    "getLockedStatus()\0QString\0getAccountName()\0"
    "selectedAccountID\0getCurrentBudget(QString)\0"
    "getCurrentBudget()\0getUsedBudget(QString)\0"
    "getUsedBudget()\0getBudgetType(QString)\0"
    "getBudgetType()\0fullValue,digit\0"
    "addDigitToValue(QString,QString)\0"
    "fullValue\0deleteDigitFromValue(QString)\0"
    "QVariantList\0getValueArray()\0budgetType\0"
    "budgetStartDate\0"
};

void ListTest::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        Q_ASSERT(staticMetaObject.cast(_o));
        ListTest *_t = static_cast<ListTest *>(_o);
        switch (_id) {
        case 0: _t->periodChanged((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 1: _t->updateGraph((*reinterpret_cast< QVariant(*)>(_a[1]))); break;
        case 2: _t->setAccountGraph(); break;
        case 3: _t->reloadWeb(); break;
        case 4: _t->emptyExpenseList(); break;
        case 5: _t->notEmptyExpenseList(); break;
        case 6: _t->checkDate(); break;
        case 7: _t->overBudgetDialogClose(); break;
        case 8: _t->addNewRecord((*reinterpret_cast< const QString(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2])),(*reinterpret_cast< const QString(*)>(_a[3])),(*reinterpret_cast< const QString(*)>(_a[4])),(*reinterpret_cast< const QString(*)>(_a[5]))); break;
        case 9: _t->updateSelectedRecord((*reinterpret_cast< const QVariant(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2])),(*reinterpret_cast< const QString(*)>(_a[3])),(*reinterpret_cast< const QString(*)>(_a[4])),(*reinterpret_cast< const QString(*)>(_a[5]))); break;
        case 10: _t->deleteItemAtIndex((*reinterpret_cast< QVariant(*)>(_a[1]))); break;
        case 11: _t->setBudget((*reinterpret_cast< const QString(*)>(_a[1])),(*reinterpret_cast< const QString(*)>(_a[2])),(*reinterpret_cast< const QString(*)>(_a[3])),(*reinterpret_cast< const QString(*)>(_a[4])),(*reinterpret_cast< bool(*)>(_a[5]))); break;
        case 12: _t->setBudget((*reinterpret_cast< const QString(*)>(_a[1])),(*reinterpret_cast< const QString(*)>(_a[2])),(*reinterpret_cast< const QString(*)>(_a[3])),(*reinterpret_cast< const QString(*)>(_a[4]))); break;
        case 13: _t->createAccount((*reinterpret_cast< const QString(*)>(_a[1])),(*reinterpret_cast< const QString(*)>(_a[2])),(*reinterpret_cast< const QString(*)>(_a[3])),(*reinterpret_cast< const QString(*)>(_a[4])),(*reinterpret_cast< const QString(*)>(_a[5]))); break;
        case 14: _t->addAccount((*reinterpret_cast< const QString(*)>(_a[1])),(*reinterpret_cast< const QString(*)>(_a[2])),(*reinterpret_cast< const QString(*)>(_a[3])),(*reinterpret_cast< const QString(*)>(_a[4])),(*reinterpret_cast< const QString(*)>(_a[5]))); break;
        case 15: _t->setAccount((*reinterpret_cast< QVariant(*)>(_a[1]))); break;
        case 16: _t->updateSumAmount((*reinterpret_cast< const QString(*)>(_a[1])),(*reinterpret_cast< const QString(*)>(_a[2]))); break;
        case 17: _t->updatePinSumAmount((*reinterpret_cast< const QString(*)>(_a[1])),(*reinterpret_cast< const QString(*)>(_a[2]))); break;
        case 18: _t->onStart(); break;
        case 19: _t->clearAmountText(); break;
        case 20: _t->clearEditAmountText(); break;
        case 21: _t->clearBudgetAmount(); break;
        case 22: _t->updateSumAmountSymbol((*reinterpret_cast< const QString(*)>(_a[1])),(*reinterpret_cast< const QString(*)>(_a[2]))); break;
        case 23: _t->editAmountText((*reinterpret_cast< const QString(*)>(_a[1]))); break;
        case 24: _t->createPin(); break;
        case 25: _t->deletePinAmount((*reinterpret_cast< const QString(*)>(_a[1]))); break;
        case 26: _t->getCreateLabel(); break;
        case 27: _t->getVerifyLabel(); break;
        case 28: _t->lockApp((*reinterpret_cast< const QString(*)>(_a[1]))); break;
        case 29: _t->fillBudgetPage(); break;
        case 30: _t->fillAddAccount(); break;
        case 31: _t->changeAccountName((*reinterpret_cast< const QString(*)>(_a[1])),(*reinterpret_cast< const QString(*)>(_a[2]))); break;
        case 32: _t->deleteAccount((*reinterpret_cast< const QString(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2]))); break;
        case 33: _t->newPeriod((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 34: _t->updatePeriodExpensesListView((*reinterpret_cast< const QString(*)>(_a[1])),(*reinterpret_cast< const QString(*)>(_a[2]))); break;
        case 35: _t->loadAccountCreation(); break;
        case 36: _t->reloadWebView(); break;
        case 37: _t->sendEmail(); break;
        case 38: _t->setUpAccountListModel(); break;
        case 39: _t->updateBar(); break;
        case 40: { bool _r = _t->loadQMLScene();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = _r; }  break;
        case 41: { bool _r = _t->verifyPin((*reinterpret_cast< const QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = _r; }  break;
        case 42: { bool _r = _t->hasPin();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = _r; }  break;
        case 43: { bool _r = _t->getLockedStatus();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = _r; }  break;
        case 44: { QString _r = _t->getAccountName();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = _r; }  break;
        case 45: { QString _r = _t->getCurrentBudget((*reinterpret_cast< const QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = _r; }  break;
        case 46: { QString _r = _t->getCurrentBudget();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = _r; }  break;
        case 47: { QString _r = _t->getUsedBudget((*reinterpret_cast< const QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = _r; }  break;
        case 48: { QString _r = _t->getUsedBudget();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = _r; }  break;
        case 49: { QString _r = _t->getBudgetType((*reinterpret_cast< const QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = _r; }  break;
        case 50: { QString _r = _t->getBudgetType();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = _r; }  break;
        case 51: { QString _r = _t->addDigitToValue((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = _r; }  break;
        case 52: { QString _r = _t->deleteDigitFromValue((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = _r; }  break;
        case 53: { QVariantList _r = _t->getValueArray();
            if (_a[0]) *reinterpret_cast< QVariantList*>(_a[0]) = _r; }  break;
        default: ;
        }
    }
}

const QMetaObjectExtraData ListTest::staticMetaObjectExtraData = {
    0,  qt_static_metacall 
};

const QMetaObject ListTest::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_ListTest,
      qt_meta_data_ListTest, &staticMetaObjectExtraData }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &ListTest::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *ListTest::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *ListTest::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_ListTest))
        return static_cast<void*>(const_cast< ListTest*>(this));
    return QObject::qt_metacast(_clname);
}

int ListTest::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 54)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 54;
    }
#ifndef QT_NO_PROPERTIES
      else if (_c == QMetaObject::ReadProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< QString*>(_v) = budgetType(); break;
        case 1: *reinterpret_cast< QString*>(_v) = budgetStartDate(); break;
        }
        _id -= 2;
    } else if (_c == QMetaObject::WriteProperty) {
        _id -= 2;
    } else if (_c == QMetaObject::ResetProperty) {
        _id -= 2;
    } else if (_c == QMetaObject::QueryPropertyDesignable) {
        _id -= 2;
    } else if (_c == QMetaObject::QueryPropertyScriptable) {
        _id -= 2;
    } else if (_c == QMetaObject::QueryPropertyStored) {
        _id -= 2;
    } else if (_c == QMetaObject::QueryPropertyEditable) {
        _id -= 2;
    } else if (_c == QMetaObject::QueryPropertyUser) {
        _id -= 2;
    }
#endif // QT_NO_PROPERTIES
    return _id;
}

// SIGNAL 0
void ListTest::periodChanged(QString _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 0, _a);
}

// SIGNAL 1
void ListTest::updateGraph(QVariant _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 1, _a);
}

// SIGNAL 2
void ListTest::setAccountGraph()
{
    QMetaObject::activate(this, &staticMetaObject, 2, 0);
}

// SIGNAL 3
void ListTest::reloadWeb()
{
    QMetaObject::activate(this, &staticMetaObject, 3, 0);
}

// SIGNAL 4
void ListTest::emptyExpenseList()
{
    QMetaObject::activate(this, &staticMetaObject, 4, 0);
}

// SIGNAL 5
void ListTest::notEmptyExpenseList()
{
    QMetaObject::activate(this, &staticMetaObject, 5, 0);
}
QT_END_MOC_NAMESPACE
