import 'package:application/modules/Transaction.dart';
import 'package:flutter/material.dart';
import 'package:application/modules/TransactionList.dart';

class MyApp extends StatefulWidget {
  final String name;
  final int age;

  MyApp({required this.name, required this.age});

  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  Transaction _transaction = Transaction(content: "Nguyên", amount: 10);
  List<Transaction> _transactions = [];

  final GlobalKey<ScaffoldMessengerState> _scalffoldMessengerKey =
      new GlobalKey<ScaffoldMessengerState>();
  final _conentController = TextEditingController();
  final _amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    print('Run initstate()');
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance!.removeObserver(this);
    print('Run dispose()');
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      print('App is in Background mode');
    } else if (state == AppLifecycleState.resumed) {
      print('App is in Foreground mode');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Đây là app",
      scaffoldMessengerKey: _scalffoldMessengerKey,
      home: Scaffold(
          appBar: AppBar(
            title: Text("Đây là AppBar"),
            actions: <Widget>[
              IconButton(
                  onPressed: () {
                    this.setState(() {
                      this._insertTransaction();
                    });
                  },
                  icon: Icon(Icons.add))
            ],
          ),
          body: SafeArea(
              child: Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text("Tự học Flutter",
                      style: TextStyle(fontSize: 30, color: Colors.blue)),
                  TextField(
                    controller: _conentController,
                    onChanged: (text) => {
                      this.setState(() {
                        _transaction.content = text;
                      })
                    },
                    decoration: InputDecoration(labelText: "Nội dung"),
                  ),
                  Padding(padding: EdgeInsets.all(5)),
                  TextField(
                    controller: _amountController,
                    onChanged: (text) => this.setState(() {
                      _transaction.amount = int.tryParse(text) ?? 0;
                    }),
                    decoration: InputDecoration(labelText: "Số tiền"),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 20),
                  TextButton(
                      style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Colors.blue,
                          padding: EdgeInsets.all(10)),
                      onPressed: () => {
                            print('Button click: ${_transaction.toString()}'),
                            _scalffoldMessengerKey.currentState!.showSnackBar(
                                SnackBar(
                                    content: Text(_transaction.toString()))),
                            this.setState(() {
                              this._insertTransaction();
                            })
                          },
                      child: Text("Xác Nhận", style: TextStyle(fontSize: 20))),
                  SizedBox(height: 20),
                  TransactionList(transactions: _transactions)
                ],
              ),
            ),
          ))),
    );
  }

  void _insertTransaction() {
    _transactions.add(_transaction);
    _transaction = Transaction(content: '', amount: 0);
    _conentController.text = '';
    _amountController.text = '';
  }
}
