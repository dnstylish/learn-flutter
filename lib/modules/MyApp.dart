import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
    if(state == AppLifecycleState.paused) {
      print('App is in Background mode');
    } else if(state == AppLifecycleState.resumed) {
      print('App is in Foreground mode');
    }
  }

  @override
  Widget build(BuildContext context) {

    DateTime time = DateTime.now();

    return MaterialApp(
      title: "Đây là app",
      home: Scaffold(
        body: Container(
          padding: EdgeInsets.only(left: 10, top: 40, right: 15, bottom: 15),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text( DateFormat('dd/mm/yyyy').format(time),
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.blue
                    )
                )
              ],
            ),
          ),
        )
      ),
    );
  }
}