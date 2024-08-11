import 'package:blog_app_with_firebase/view/screens/splash_screen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // name: "Blog Daily App",
    options: const FirebaseOptions(
      apiKey: "AIzaSyAHXaYpVm1yrX_Bq5g3gi5jc4mHIvDsf_E",
      appId: "1:382821376970:android:d098e92dd9827312bf6533",
      messagingSenderId: "382821376970",
      projectId: "blog-daily-app",
      storageBucket: "gs://blog-daily-app.appspot.com",
    ),
  );
  runApp(const BlogApp());
}

class BlogApp extends StatelessWidget {
  const BlogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
