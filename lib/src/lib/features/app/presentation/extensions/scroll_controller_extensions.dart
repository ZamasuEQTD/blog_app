import 'package:flutter/material.dart';

extension ScrollControllerExtensions on ScrollController {
  bool get IsBottom => position.pixels == position.maxScrollExtent;
}
