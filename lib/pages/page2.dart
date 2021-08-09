import 'package:flutter/material.dart';

class Page2 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Page 2'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('Fingerprint 2');
        },
      )
    );
  }
}