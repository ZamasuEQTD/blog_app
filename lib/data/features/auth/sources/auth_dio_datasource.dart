import 'package:blog_app/core/classes/failure.dart';
import 'package:blog_app/data/features/auth/abstractions/iauth_datasource.dart';
import 'package:blog_app/data/features/auth/models/login_request.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class AuthDioDatasource extends IAuthDatasource {
  final Dio dio;

  AuthDioDatasource(this.dio);
  
  @override
  Future<Either<Failure, String>> login(LoginRequest request) async{
    throw UnimplementedError();
  }
}