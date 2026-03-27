import 'package:exam_a_app/config/base_response/base_response.dart';
import 'package:exam_a_app/feature/auth/register/data/model/register_request.dart';
import 'package:exam_a_app/feature/auth/register/domain/model/user_model.dart';

abstract class RegisterRepoContract {
  Future<BaseResponse<RegisterModel>> register(RegisterRequest request);
}
