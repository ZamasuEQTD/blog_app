import 'package:blog_app/features/app/clases/failure.dart';
import 'package:blog_app/features/baneos/domain/models/baneo.dart';

class EstasBaneadoFailure extends Failure {
  static const String title = "Baneos.HasSidoBaneado";
  final Baneo baneo;
  const EstasBaneadoFailure({
    required this.baneo,
    super.descripcion,
  }) : super(
          code: title,
        );
}
