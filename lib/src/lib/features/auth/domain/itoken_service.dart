import 'package:blog_app/features/auth/domain/models/usuario.dart';
import 'package:blog_app/src/lib/utils/clases/failure.dart';
import 'package:dartz/dartz.dart';

abstract class ITokenService {
  Future<Usuario> decrpyt(String token);
}
