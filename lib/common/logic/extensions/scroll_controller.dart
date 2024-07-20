import 'package:flutter/material.dart';

extension ScrollControllerExtensions on ScrollController {
  bool isBottom(){
    if (!hasClients) return false;
    final maxScroll =  position.maxScrollExtent;
    final currentScroll = offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
