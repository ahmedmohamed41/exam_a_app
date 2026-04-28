import 'package:exam_a_app/config/base_response/base_response.dart';
import 'package:exam_a_app/feature/profile/domain/models/user_data_model.dart';
import 'package:exam_a_app/feature/profile/domain/repo/profile_repo_contract.dart';
import 'package:injectable/injectable.dart';
@injectable
class GetUserProfileUseCase {
  final ProfileRepoContract _profileRepoContract;

  GetUserProfileUseCase(this._profileRepoContract);
    Future<BaseResponse<UserDataModel>> call() async {
    return await _profileRepoContract.getProfile();
  }
}
