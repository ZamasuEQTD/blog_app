import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  final String error;
  final String? descripcion;

  const Failure(this.error, [this.descripcion]);

  static const Failure unknow = Failure("Erros.Unknow", "Error Desconocido");

  @override
  List<Object?> get props => [error];
}
