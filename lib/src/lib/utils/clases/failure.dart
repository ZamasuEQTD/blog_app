import 'package:equatable/equatable.dart';

class Failure {
  final String code;
  final String? descripcion;

  const Failure({required this.code, this.descripcion});
}
