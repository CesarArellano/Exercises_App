import 'package:flutter/material.dart';

// Pages 
import 'package:exercises_app/pages/page1.dart';
import 'package:exercises_app/pages/page2.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: 'page1',
      routes: {
        'page1' : (_) => Page1(),
        'page2' : (_) => Page2(),
      },
    );
  }
}