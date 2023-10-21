import 'package:flutter/material.dart';

import '../period_tracking/main.dart';

class WelcomePage extends StatelessWidget {
  static String id = 'welcome_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => MyCycles()),
            );
          },
          child: Text('Let\'s start'),
        ),
      ),
    );
  }
}
