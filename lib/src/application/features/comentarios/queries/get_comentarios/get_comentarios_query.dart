import 'package:blog_app/src/application/abstractions/messaging/iquery.dart';
import 'package:blog_app/src/domain/features/comentarios/models/comentario.dart';
import 'package:dartz/dartz.dart';

import '../../../../../shared_kernel/failure.dart';

class GetComentariosQuery extends IQuery<Either<Failure,List<Comentario>>> {
  final int pagina;
  final String id;

  GetComentariosQuery({required this.pagina, required this.id});
}