import 'dart:collection';

import 'package:dio/dio.dart';

extension ReponseExtension on Response {
  static final HashSet<int> _successCodes = HashSet.from([200, 201, 204]);

  bool get isFailure => !isSuccess;
  bool get isSuccess => _successCodes.contains(statusCode);
}
