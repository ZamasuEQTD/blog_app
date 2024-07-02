import 'package:flutter/material.dart';

class HiloIconFeature extends StatelessWidget {
  final IconData iconData;
  const HiloIconFeature({
    super.key,
    required this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
                color: const Color.fromRGBO(199, 199, 199, 1), width: 1.25)),
        height: 30,
        width: 30,
        padding: const EdgeInsets.all(4),
        child: FittedBox(child: Icon(iconData)),
      ),
    );
  }
}
