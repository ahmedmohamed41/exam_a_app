import 'package:exam_a_app/config/base_response/base_response.dart';
import 'package:exam_a_app/feature/profile/domain/models/user_data_model.dart';
import 'package:exam_a_app/feature/profile/domain/repo/profile_repo_contract.dart';
import 'package:injectable/injectable.dart';
import '../models/edit_profile_params.dart';

@injectable
class EditProfileUseCase {
  final ProfileRepoContract _profileRepoContract;

  EditProfileUseCase(this._profileRepoContract);

  Future<BaseResponse<UserDataModel>> call(EditProfileParams params) async {
    return _profileRepoContract.editProfile(params);
  }
}
