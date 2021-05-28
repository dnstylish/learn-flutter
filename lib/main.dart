import 'package:application/modules/MyApp.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      title: "Học flutter",
      theme: ThemeData(
        primaryColor: Colors.redAccent
      ),
      home: MyApp(name: "Nguyên", age: 22),
    )
  );
}