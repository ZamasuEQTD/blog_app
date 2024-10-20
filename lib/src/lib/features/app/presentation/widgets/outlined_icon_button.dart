import 'package:flutter/material.dart';

class OutlinedIcon extends StatelessWidget {
  final Widget child;
  const OutlinedIcon({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: const Color.fromRGBO(199, 199, 199, 1),
          width: 1.25,
        ),
      ),
      child: child,
    );
  }
}
