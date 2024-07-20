import 'package:blog_app/domain/features/hilo/entities/hilo.dart';

class GetHiloRequest {
  final HiloId id;

  const GetHiloRequest({required this.id});
}
