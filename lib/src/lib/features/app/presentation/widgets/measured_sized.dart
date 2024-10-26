import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

typedef OnWidgetSizeChange = void Function(Size size);

class AlturaNotifier extends StatelessWidget {
  final GlobalKey widgetKey = GlobalKey();
  final Widget child;
  final OnWidgetSizeChange onSizeChange;
  AlturaNotifier({super.key, required this.child, required this.onSizeChange});

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      onNotification: _onNotification,
      child: SizeChangedLayoutNotifier(
        child: Container(
          key: widgetKey,
          child: child,
        ),
      ),
    );
  }

  bool _onNotification(Notification onNotification) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      // Obtienes la altura del widget usando la llave
      final size = widgetKey.currentContext?.size!;
      // Actualizas el valor de la altura con la nueva altura
      if (size != null) {
        onSizeChange(size);
      }
    });
    return true;
  }
}
