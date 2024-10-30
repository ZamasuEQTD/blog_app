import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  final String code;
  final String? descripcion;

  const Failure({required this.code, this.descripcion});

  @override
  // TODO: implement props
  List<Object?> get props => [code, descripcion];
}
