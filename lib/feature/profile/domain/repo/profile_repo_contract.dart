import 'package:exam_a_app/config/base_response/base_response.dart';
import 'package:exam_a_app/feature/profile/domain/models/user_data_model.dart';
import '../models/edit_profile_params.dart';

abstract class ProfileRepoContract {
  Future<BaseResponse<UserDataModel>> getProfile();
  Future<BaseResponse<UserDataModel>> editProfile(EditProfileParams params);
}
