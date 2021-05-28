import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'Transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionList({required this.transactions});

  ListView _listViewBuilder() {
    return ListView.builder(
        itemCount: this.transactions.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
              color: Colors.green,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(this.transactions[index].content.toString().trim(),
                            style: TextStyle(color: Colors.white)),
                        Text(
                            'Date: ${DateFormat("dd/MM/yyyy").format(this.transactions[index].createdAt as DateTime)}')
                      ],
                    ),
                    Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                  '${this.transactions[index].amount.toString().trim()}\$',
                                  style: TextStyle(color: Colors.white)
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.all(Radius.circular(10))
                              ),
                            )
                          ],
                        )
                    )
                  ],
                ),
              ));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: this._listViewBuilder(),
    );
  }
}
