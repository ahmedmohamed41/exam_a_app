import 'dart:async';
import 'package:dio/dio.dart';
import 'package:exam_a_app/config/base_response/base_response.dart';
import 'package:exam_a_app/feature/profile/api/profile_api_client/profile_api_client.dart';
import 'package:exam_a_app/feature/profile/data/data_sources/profile_remote_data_source_contract.dart';
import 'package:exam_a_app/feature/profile/data/models/request/edit_profile_request.dart';
import 'package:exam_a_app/feature/profile/data/models/user_data_dto.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProfileRemoteDataSourceContract)
class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSourceContract {
  final ProfileApiClient _profileApiClient;

  ProfileRemoteDataSourceImpl(this._profileApiClient);

  @override
  Future<BaseResponse<UserDataDto>> getProfile() async {
    try {
      final response = await _profileApiClient.getUserProfile();
      return SuccessResponse<UserDataDto>(data: response.user!);
    } catch (e) {
      if (e is DioException) {
        return ErrorResponse<UserDataDto>(
          errorMessage: e.message ?? 'Dio Exception',
        );
      } else if (e is TimeoutException) {
        return ErrorResponse<UserDataDto>(
          errorMessage: e.message ?? 'Request Time out ,Please try again later',
        );
      }
      return ErrorResponse<UserDataDto>(
        errorMessage: 'Something went wrong ,Please try again later',
      );
    }
  }

  @override
  Future<BaseResponse<UserDataDto>> editProfile(
    EditProfileRequest request,
  ) async {
    try {
      final response = await _profileApiClient.editProfile(request);
      return SuccessResponse<UserDataDto>(data: response.user!);
    } catch (e) {
      if (e is DioException) {
        return ErrorResponse<UserDataDto>(
          errorMessage: e.message ?? 'Dio Exception',
        );
      } else if (e is TimeoutException) {
        return ErrorResponse<UserDataDto>(
          errorMessage: e.message ?? 'Request Time out ,Please try again later',
        );
      }
      return ErrorResponse<UserDataDto>(
        errorMessage: 'Something went wrong ,Please try again later',
      );
    }
  }
}
