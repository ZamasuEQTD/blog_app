import 'package:blog_app/src/lib/features/baneos/domain/models/types.dart';
import 'package:blog_app/src/lib/features/baneos/presentation/screens/logic/controllers/banear_usuario.dart';
import 'package:equatable/equatable.dart';

class Baneo extends Equatable {
  final BaneoId id;
  final Razon razon;
  final String moderador;
  final DateTime? finaliza;
  final String? mensaje;

  const Baneo({
    required this.id,
    required this.razon,
    required this.moderador,
    this.finaliza,
    this.mensaje,
  });

  factory Baneo.fromJson(Map<String, dynamic> json) {
    return Baneo(
      id: json["id"],
      razon: Razon.values[json["razon"]],
      moderador: json["moderador"],
      finaliza: DateTime.parse(json["finaliza"]),
      mensaje: json["mensaje"],
    );
  }

  @override
  List<Object?> get props => [];
}
