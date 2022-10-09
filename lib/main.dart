import 'package:adam_asmaca/screens/home.dart';

import 'package:flutter/material.dart';
import 'package:wakelock/wakelock.dart';

void main() async {
  Wakelock.enable();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeApp(),
    );
  }
}
