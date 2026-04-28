import 'package:exam_a_app/feature/auth/register/data/model/register_request.dart';
import 'package:exam_a_app/feature/auth/register/data/model/register_response.dart';

abstract interface class RegisterRemoteDatasourceContract {
  Future<RegisterResponse> register(RegisterRequest request);
}
