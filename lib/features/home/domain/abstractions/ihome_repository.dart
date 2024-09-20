// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import '../../../../core/classes/failure.dart';
import '../models/home_portada_entry.dart';

abstract class IHomeRepository {
  Future<Either<Failure, List<HomePortadaEntity>>> getPortadas(
      GetHomePortadasRequest request);
}

class GetHomePortadasRequest {
  final String? titulo;
  final String? categoria;
  final DateTime? ultimoBump;
  const GetHomePortadasRequest({
    this.titulo,
    this.categoria,
    this.ultimoBump,
  });
}
