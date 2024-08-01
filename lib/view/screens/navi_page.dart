
import 'package:blog_app_with_firebase/auth/registers/sign_up.dart';
import 'package:blog_app_with_firebase/auth/sign_in/sign_in.dart';
import 'package:blog_app_with_firebase/golobal_wieght/round_button.dart';
import 'package:flutter/material.dart';

class NavigatorPage extends StatefulWidget {
  const NavigatorPage({super.key});

  @override
  State<NavigatorPage> createState() => _NavigatorPageState();
}

class _NavigatorPageState extends State<NavigatorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Image.asset(
                    "assets/images/blog.png",
                    height: 400,
                  ),
                ],
              ),
              Column(
                children: [
                  RoundButton(
                    title: 'Log In',
                    onPress: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignInPage()));
                    },
                    color: Colors.deepOrangeAccent,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  RoundButton(
                    title: 'Register',
                    onPress: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUpPage()));
                    },
                    color: Colors.deepPurple,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
