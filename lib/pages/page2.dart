import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';

class Page2 extends StatelessWidget {
  final InAppReview inAppReview = InAppReview.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('In App Review'),
      ),
      body: Center(
        child: MaterialButton(
          color: Colors.blue,
          child: Text('Rated App', style: TextStyle(color: Colors.white)),
          elevation: 3,
          onPressed: () async {
            print('Review in app');
            if (await inAppReview.isAvailable()) {
              inAppReview.requestReview();
            } else {
              print('Error');
            }
          },
        )
      ),
    );
  }
}