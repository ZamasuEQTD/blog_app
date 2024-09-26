import 'package:flutter/material.dart';

class ReproductorDeVideoControl extends StatelessWidget {
  final Widget icon;
  final double size;
  final void Function() onTap;
  const ReproductorDeVideoControl(
      {super.key, required this.icon, required this.size, required this.onTap});

  factory ReproductorDeVideoControl.icon(
      {Key? key,
      required double size,
      required IconData icon,
      required void Function() onTap}) {
    return ReproductorDeVideoControl(
      key: key,
      size: size,
      onTap: onTap,
      icon: Icon(icon, color: Colors.white),
    );
  }
  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: ColoredBox(
        color: Colors.black.withOpacity(0.6),
        child: SizedBox(
          height: size,
          width: size,
          child: GestureDetector(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: FittedBox(child: icon),
            ),
          ),
        ),
      ),
    );
  }
}
