import 'package:exam_a_app/config/base_response/base_response.dart';
import 'package:exam_a_app/core/constant/storage_keys.dart';
import 'package:exam_a_app/core/storage/secure_storage.dart';
import 'package:exam_a_app/core/utils/error_handler.dart';
import 'package:exam_a_app/feature/profile_change_password/data/data_source/change_password_remote_data_source.dart';
import 'package:exam_a_app/feature/profile_change_password/domain/model/change_password_details.dart';
import 'package:exam_a_app/feature/profile_change_password/domain/repo/change_password_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ChangePasswordRepo)
class ChangePasswordRepoImpl implements ChangePasswordRepo {
  final ChangePasswordRemoteDataSource _dataSource;
  final SecureStorage _secureStorage;

  ChangePasswordRepoImpl(this._dataSource, this._secureStorage);

  @override
  Future<BaseResponse<ChangePasswordDetails>> changePassword({
    required String oldPassword,
    required String password,
    required String rePassword,
  }) async {
    try {
      final response = await _dataSource.changePassword(
        oldPassword: oldPassword,
        password: password,
        rePassword: rePassword,
      );
      final details = response.toDetails();
      if (details.token != null && details.token!.isNotEmpty) {
        await _secureStorage.saveToken(
          details.token!,
          key: StorageKeys.authToken,
        );
      }
      return SuccessResponse<ChangePasswordDetails>(data: details);
    } catch (e) {
      return ErrorResponse<ChangePasswordDetails>(
        errorMessage: ErrorHandler.handle(e),
      );
    }
  }
}
