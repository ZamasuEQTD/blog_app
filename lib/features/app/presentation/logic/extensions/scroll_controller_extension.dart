import 'package:flutter/material.dart';

extension ScrollControllerExtensions on ScrollController {
  bool get isBottom => position.pixels == position.maxScrollExtent;
}
