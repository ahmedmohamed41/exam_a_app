import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../core/constant/end_point.dart';
import 'auth_interceptor.dart';

@module
abstract class DioModule {
  @singleton
  Dio getDio(AuthInterceptor authInterceptor) {
    final dio = Dio(
      BaseOptions(
        baseUrl: EndPoint.baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
    );
    dio.interceptors.add(authInterceptor);
    return dio;
  }
}
