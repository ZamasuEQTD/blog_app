import 'package:flutter/widgets.dart';

extension TextStyles on BuildContext {
  TextStyle get labelStyle => const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Color.fromRGBO(73, 80, 87, 1),
      );
}
