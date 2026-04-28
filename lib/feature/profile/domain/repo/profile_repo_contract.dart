import 'package:exam_a_app/config/base_response/base_response.dart';
import 'package:exam_a_app/feature/profile/data/models/request/edit_profile_request.dart';
import 'package:exam_a_app/feature/profile/domain/models/user_data_model.dart';

abstract class ProfileRepoContract {
  Future<BaseResponse<UserDataModel>> getProfile();
  Future<BaseResponse<UserDataModel>> editProfile(EditProfileRequest request);
}
