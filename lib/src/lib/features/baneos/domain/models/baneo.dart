import 'package:blog_app/src/lib/features/baneos/domain/models/types.dart';
import 'package:equatable/equatable.dart';

class Baneo extends Equatable {
  final BaneoId id;
  final String moderador;
  final DateTime finaliza;
  final String? mensaje;

  const Baneo({
    required this.id,
    required this.moderador,
    required this.finaliza,
    this.mensaje,
  });
  @override
  List<Object?> get props => [];
}
