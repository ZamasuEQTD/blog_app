import 'package:blog_app/src/application/abstractions/messaging/iquery.dart';
import 'package:blog_app/src/application/abstractions/messaging/iquery_handler.dart';
import 'package:blog_app/src/application/features/comentarios/queries/get_comentarios/get_comentarios_query.dart';
import 'package:blog_app/src/domain/features/comentarios/models/comentario.dart';
import 'package:dartz/dartz.dart';

import '../../../../../domain/features/comentarios/abstractions/icomentarios_repository.dart';
import '../../../../../shared_kernel/failure.dart';

class GetComentariosQueryHandler extends IQueryHandler<GetComentariosQuery, Either<Failure,List<Comentario>>> {
  final IComentariosRepository repository;

  const GetComentariosQueryHandler(this.repository);

  @override
  Future<Either<Failure, List<Comentario>>> handle(GetComentariosQuery request) {
    return repository.getComentarios(id: request.id, pagina: request.pagina);
  }
}