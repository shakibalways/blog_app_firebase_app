import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
 final String title;
  final VoidCallback onPress;
 final Color color;

  const RoundButton(
      {super.key,
      required this.title,
      required this.onPress,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      clipBehavior: Clip.antiAlias,
      child: MaterialButton(
          height: 50,
          minWidth: double.infinity,
          color: color,
          onPressed: onPress,
          child: Text(title, style: const TextStyle(color: Colors.white))),
    );
  }
}
