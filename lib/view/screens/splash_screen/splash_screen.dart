

import 'dart:async';

import 'package:blog_app_with_firebase/view/screens/home_screen.dart';
import 'package:blog_app_with_firebase/view/screens/navi_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final user = auth.currentUser;
    if (user != null) {
      Timer(
          const Duration(seconds: 3),
          () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => const HomeScreen())));
    } else {
      Timer(
          const Duration(seconds: 3),
              () => Navigator.push(
              context, MaterialPageRoute(builder: (context) =>const NavigatorPage())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0a1e3d),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/hjgj.png",
              height: MediaQuery.of(context).size.height * .3,
            ),
            Image.asset(
              "assets/images/blog_text.png",
              height: MediaQuery.of(context).size.height * .2,
            ),
          ],
        ),
      ),
    );
  }
}
