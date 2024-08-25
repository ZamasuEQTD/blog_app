import 'package:flutter/material.dart';

import '../../../domain/services/tag_service.dart';

class TaggueosController extends ChangeNotifier {
  String? tag;

  TaggueosController();

  void tagguear({required String texto, required String tag}) {
    List<String> tags = TagService.getTags(texto);

    if (tags.length == 5 || tags.contains(tag)) {
      this.tag = null;

      return;
    }

    this.tag = tag;

    notifyListeners();
  }
}
