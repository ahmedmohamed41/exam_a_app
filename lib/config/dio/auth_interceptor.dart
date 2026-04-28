import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../../core/storage/secure_storage.dart';
import '../../../core/constant/storage_keys.dart';

@injectable
class AuthInterceptor extends Interceptor {
  final SecureStorage _secureStorage;

  AuthInterceptor(this._secureStorage);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _secureStorage.getToken(key: StorageKeys.authToken);

    if (token != null && token.isNotEmpty) {
      options.headers['token'] = token;
    }

    super.onRequest(options, handler);
  }
}
