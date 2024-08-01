import 'package:flutter/material.dart';
import 'package:blog_app_with_firebase/view/screens/page.dart';
class NotShowing extends StatefulWidget {
  const NotShowing({super.key});

  @override
  State<NotShowing> createState() => _NotShowingState();
}

class _NotShowingState extends State<NotShowing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("shakib",style: TextStyle(color: Colors.pink),),
      ),
    );
  }
}
