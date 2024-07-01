import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FlatIconBtn extends StatelessWidget {
  final Widget icon;
  final Color? color;
  final double size;
  final void Function()? onTap;
  const FlatIconBtn({super.key, required this.icon, this.onTap, this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Container(
          color: color?? CupertinoColors.systemGrey.withOpacity(0.15),
          height: size,
          width: size,
          child:FittedBox(
            child: icon
          ),
        ),
      ),
    );
  }
}
