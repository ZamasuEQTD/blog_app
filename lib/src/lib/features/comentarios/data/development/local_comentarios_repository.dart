import 'dart:math';

import 'package:blog_app/src/lib/features/app/domain/models/spoileable.dart';
import 'package:blog_app/src/lib/features/comentarios/domain/icomentarios_repository.dart';
import 'package:blog_app/src/lib/features/comentarios/domain/models/comentario.dart';
import 'package:blog_app/src/lib/features/comentarios/domain/models/typedef.dart';
import 'package:blog_app/src/lib/features/hilo/domain/models/types.dart';
import 'package:blog_app/src/lib/features/media/domain/models/media.dart';
import 'package:blog_app/src/lib/utils/clases/failure.dart';
import 'package:dartz/dartz.dart';

class LocalComentariosRepository extends IComentariosRepository {
  @override
  Future<Either<Failure, List<Comentario>>> getComentarios({
    required HiloId hilo,
    DateTime? ultimoComentario,
  }) {
    return Future.delayed(
      const Duration(seconds: 3),
      () => Right([
        Comentario(
          id: Random().nextInt(150000).toString(),
          texto:
              "https://play.max.com/video/watch/54c9a2ac-0eae-4215-b70a-2afea02982f7/4b7fa446-a2d9-45c9-9b85-69dee077bb58",
          creado_en: DateTime(2024, 5, 1, 2),
          color: ColoresDeComentario.amarillo,
          destacado: false,
          autor: const Autor(
            nombre: "ANONIMO",
            rango: "ANONIMO",
            rangoCorto: "ANON",
          ),
          tag: "CPDENEN",
          tags: ["CPDENEN", "CPDENEN", "CPDENEN", "CPDENEN"],
          taggueos: [],
        ),
        Comentario(
          id: Random().nextInt(150000).toString(),
          texto: "Aguante la bornografia>>CPDENEN>>CPDENEN>>CPDENEN",
          creado_en: DateTime(2024, 5, 1, 2),
          color: ColoresDeComentario.multi,
          destacado: false,
          autor: const Autor(
            nombre: "ANONIMO",
            rango: "ANONIMO",
            rangoCorto: "ANON",
          ),
          tagUnico: "CP3",
          tag: "CPDENEN",
          tags: ["CPDENEN", "CPDENEN", "CPDENEN", "CPDENEN"],
          taggueos: [],
        ),
        Comentario(
          id: Random().nextInt(150000).toString(),
          texto: "Aguante la bornografia",
          creado_en: DateTime(2024, 5, 1, 2),
          color: ColoresDeComentario.rojo,
          destacado: false,
          autor: const Autor(
            nombre: "ANONIMO",
            rango: "ANONIMO",
            rangoCorto: "ANON",
          ),
          tag: "CPDENEN",
          tags: ["CPDENEN", "CPDENEN", "CPDENEN", "CPDENEN"],
          taggueos: [],
        ),
        Comentario(
          id: Random().nextInt(150000).toString(),
          texto: "Aguante la bornografia",
          creado_en: DateTime(2024, 5, 1, 2),
          color: ColoresDeComentario.rojo,
          destacado: false,
          autor: const Autor(
            nombre: "ANONIMO",
            rango: "ANONIMO",
            rangoCorto: "ANON",
          ),
          tag: "CPDENEN",
          tags: ["NENILLA", "CPDENEN", "CPDENEN", "CPDENEN"],
          taggueos: [],
        ),
      ]),
    );
  }

  @override
  Future<Either<Failure, Unit>> enviar({
    required HiloId hilo,
    required String comentario,
    Spoileable<Media>? media,
  }) {
    // TODO: implement enviar
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> eliminar({required ComentarioId id}) {
    // TODO: implement eliminar
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> ocultar({required ComentarioId id}) {
    // TODO: implement ocultar
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> denunciar({required ComentarioId id}) {
    // TODO: implement denunciar
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> destacar({
    required HiloId hilo,
    required ComentarioId comentario,
  }) {
    // TODO: implement destacar
    throw UnimplementedError();
  }
}
