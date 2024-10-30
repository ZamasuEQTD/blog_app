import 'package:blog_app/src/lib/features/baneos/domain/models/baneo.dart';
import 'package:blog_app/src/lib/utils/clases/failure.dart';

class EstasBaneadoFailure extends Failure {
  final Baneo baneo;
  const EstasBaneadoFailure({
    required this.baneo,
    required super.code,
  }) : super(descripcion: "Estas baneado!");
}
