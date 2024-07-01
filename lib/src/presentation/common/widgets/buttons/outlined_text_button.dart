import 'package:flutter/material.dart';

class OutlinedTextButton extends StatelessWidget {
  final void Function()? onTap;
  final Color? color;
  final double? width;
  final TextStyle? textStyle;
  final String txt;
  const OutlinedTextButton({
    super.key,
    this.onTap,
    this.color,
    required this.txt,
    this.width,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
            onTap:onTap,
            child: Container(
              padding: const EdgeInsets.symmetric(
                  vertical: 10, horizontal: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white, width: 1)),
              child: const Text(
                "Ver contenido",
                style: TextStyle(color: Colors.white),
              ),
        ),
      );
  }
}
