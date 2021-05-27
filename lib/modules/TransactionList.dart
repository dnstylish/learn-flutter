import 'package:flutter/material.dart';

import 'Transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionList({required this.transactions});

  ListView _listViewBuilder() {
    return ListView.builder(
        itemCount: this.transactions.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
              color: Colors.pinkAccent,
              child: ListTile(
                  leading: const Icon(Icons.account_balance_wallet_rounded,
                      color: Colors.white),
                  title: Text(this.transactions[index].content.toString(),
                      style: TextStyle(color: Colors.white)),
                  subtitle: Text(this.transactions[index].amount.toString(),
                      style: TextStyle(color: Colors.white))));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      child: this._listViewBuilder(),
    );
  }
}
