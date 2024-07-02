import 'package:flutter/material.dart';

class AccionDeHiloBtn extends StatelessWidget {
  final IconData iconData;
  final void Function()? onTap;
  const AccionDeHiloBtn({super.key, required this.iconData, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        width: 40,
        padding: const EdgeInsets.all(4),
        child: Center(
          child: Icon(
            iconData,
          ),
        ),
      ),
    );
  }
}
