import 'package:blog_app/src/lib/features/comentarios/domain/icomentarios_repository.dart';
import 'package:blog_app/src/lib/features/comentarios/domain/models/comentario.dart';
import 'package:blog_app/src/lib/features/hilo/domain/models/types.dart';
import 'package:blog_app/src/lib/utils/clases/failure.dart';
import 'package:dartz/dartz.dart';

class LocalComentariosRepository extends IComentariosRepository {
  @override
  Future<Either<Failure, List<Comentario>>> getComentarios({
    required HiloId hilo,
    DateTime? ultimoComentario,
  }) {
    return Future.value(
      Right([
        Comentario(
          id: "12",
          texto: "Aguante la bornografia",
          creado_en: DateTime(2000, 5, 1, 2),
          color: ColoresDeComentario.rojo,
          op: const OpData(
            nombre: "ANONIMO",
            rango: "ANONIMO",
            rangoCorto: "ANON",
          ),
          tag: "CPDENEN",
          tags: ["CPDENEN", "CPDENEN", "CPDENEN", "CPDENEN"],
          taggueos: [],
        ),
        Comentario(
          id: "3231",
          texto: "Aguante la bornografia",
          creado_en: DateTime(2000, 5, 1, 2),
          color: ColoresDeComentario.multi,
          op: const OpData(
            nombre: "ANONIMO",
            rango: "ANONIMO",
            rangoCorto: "ANON",
          ),
          tag: "CPDENEN",
          tags: ["CPDENEN", "CPDENEN", "CPDENEN", "CPDENEN"],
          taggueos: [],
        ),
      ]),
    );
  }
}
