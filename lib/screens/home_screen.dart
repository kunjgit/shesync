import 'package:flutter/material.dart';
import 'package:shesync/components/components.dart';
import 'package:shesync/screens/signup_screen.dart';
import 'login_screen.dart';

class HomeScreen extends StatelessWidget {
  static String id = 'home_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // const TopScreenImage(screenImageName: 'home.jpg'),
            // const SizedBox(height: 20),
            Column(
              children: [
                const ScreenTitle(title: 'Hello'),
                const SizedBox(height: 10),
                const Text(
                  'Welcome to SheSync this is the place you will love',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 20),
                Hero(
                  tag: 'login_btn',
                  child: CustomButton(
                    buttonText: 'Login',
                    onPressed: () {
                      Navigator.pushNamed(context, LoginScreen.id);
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Hero(
                  tag: 'signup_btn',
                  child: CustomButton(
                    buttonText: 'Sign Up',
                    isOutlined: true,
                    onPressed: () {
                      Navigator.pushNamed(context, SignUpScreen.id);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
