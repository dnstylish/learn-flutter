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
  Transaction _transaction =
      Transaction(content: "Nguyên", amount: 10, createdAt: DateTime.now());
  List<Transaction> _transactions = [];

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

  void _onButtonShowModal() {
    showModalBottomSheet(
        context: this.context,
        builder: (content) {
          return Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      TextButton(
                        onPressed: () {
                          this.setState(() {
                            this._insertTransaction();
                          });
                          Navigator.of(context).pop();
                        },
                        child: Text("Xác Nhận",
                            style: TextStyle(color: Colors.white)),
                        style: TextButton.styleFrom(
                            primary: Colors.greenAccent,
                            backgroundColor: Colors.green),
                      ),
                      SizedBox(width: 10),
                      TextButton(
                        onPressed: () {
                          // ẩn modal
                          Navigator.of(context).pop();
                        },
                        child: Text("Huỷ Bỏ",
                            style: TextStyle(color: Colors.white)),
                        style: TextButton.styleFrom(
                            primary: Colors.redAccent,
                            backgroundColor: Colors.redAccent),
                      )
                    ],
                  )
                ],
              ));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Đây là AppBar"),
          actions: <Widget>[
            IconButton(
                onPressed: () {
                  this._onButtonShowModal();
                },
                icon: Icon(Icons.add))
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            this._onButtonShowModal();
          },
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: SafeArea(
            child: Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: TransactionList(transactions: _transactions),
        )));
  }

  void _insertTransaction() {
    _transaction.createdAt = DateTime.now();
    _transactions.add(_transaction);
    _transaction =
        Transaction(content: '', amount: 0, createdAt: DateTime.now());
    _conentController.text = '';
    _amountController.text = '';
  }
}
