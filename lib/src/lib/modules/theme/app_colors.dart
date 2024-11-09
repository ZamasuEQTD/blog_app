import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// class AppColors {
//   const AppColors._();

//   // Blanco - Fondo principal
//   static const Color primary = Color(0xFFFFFFFF);

//   // Gris oscuro - Texto principal
//   static const Color onPrimary = Color(0xFF495057);

//   // Gris más claro - Fondo secundario
//   static const Color secondary = Color(0xFFF8F9FA);

//   // Gris medio - Texto secundario, iconos
//   static const Color onSecondary = Color(0xFFADB5BD);

//   // Blanco - Mantiene el color de superficie como blanco
//   static const Color surface = Color(0xFFFFFFFF);

//   // Gris claro - Bordes, separadores
//   static const Color onSurface = Color(0xFFE9ECEF);

//   // Gris muy oscuro - Énfasis, encabezados (reemplazando el color de error)
//   static const Color error = Color(0xFF212529);

//   // Blanco - Manteniendo el contraste para texto sobre el color de error
//   static const Color onError = Color(0xFFFFFFFF);

//   // Añadiendo algunos colores adicionales de nuestra paleta para más flexibilidad
//   static const Color grayMediumLight =
//       Color(0xFFDEE2E6); // Elementos interactivos inactivos
//   static const Color grayDark = Color(
//     0xFF495057,
//   ); // Texto principal (duplicado de onPrimary para claridad)
// }

class AppColors {
  const AppColors._();

  static const Color primary = Color.fromRGBO(22, 22, 23, 1);

  static const Color onPrimary = Color.fromRGBO(255, 255, 225, 1);

  static const Color surface = Color(0xffF1F1F1);

  static const Color onSurface = Color.fromRGBO(255, 255, 255, 1);

  static const Color error = primary;

  static const Color onError = onPrimary;

  static const Color secondary = Color.fromRGBO(233, 236, 239, 1);

  static const Color onSecondary = Color.fromRGBO(73, 80, 87, 1);
}
