import 'package:flutter/material.dart';

class AuthLabel extends StatelessWidget {
  final String text;
  const AuthLabel({
    super.key, 
    required this.text
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.w700
      )
    );
  }
}