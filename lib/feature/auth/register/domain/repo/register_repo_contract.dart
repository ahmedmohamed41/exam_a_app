import 'package:exam_a_app/config/base_response/base_response.dart';
import 'package:exam_a_app/feature/auth/register/domain/model/register_details.dart';
import '../model/register_params.dart';

abstract interface class RegisterRepoContract {
  Future<BaseResponse<RegisterDetails>> register(RegisterParams params);
}
