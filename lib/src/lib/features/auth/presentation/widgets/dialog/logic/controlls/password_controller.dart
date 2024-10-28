import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PasswordController extends GetxController {
  var obscure = true.obs;

  void ocultar() {
    obscure.value = !obscure.value;
  }
}
