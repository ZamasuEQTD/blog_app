import 'package:flutter/material.dart';

typedef OnWidgetSizeChange = void Function(Size size);

class MeasureSize extends StatefulWidget {
  final Widget child;
  final OnWidgetSizeChange onChange;

  const MeasureSize({
    super.key,
    required this.onChange,
    required this.child,
  });

  @override
  createState() => _MeasureSizeState();
}

class _MeasureSizeState extends State<MeasureSize> {
  var widgetKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => widget.onChange(widgetKey.currentContext!.size!),
    );

    return SizedBox(
      key: widgetKey,
      child: widget.child,
    );
  }
}
