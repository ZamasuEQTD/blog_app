import 'package:blog_app/features/app/clases/failure.dart';
import 'package:blog_app/features/baneos/domain/models/baneo.dart';

class EstasBaneadoFailure extends Failure {
  final Baneo baneo;
  const EstasBaneadoFailure({
    required this.baneo,
  }) : super(
          code: "baneos.baneado",
          descripcion: "Estas baneado!",
        );
}
