import 'package:exam_a_app/config/base_response/base_response.dart';
import 'package:exam_a_app/core/storage/hive_storage_contract.dart';
import 'package:exam_a_app/core/storage/secure_storage.dart';
import 'package:exam_a_app/feature/profile/domain/models/user_data_model.dart';
import 'package:exam_a_app/feature/profile/domain/use_case/edit_profile_use_case.dart';
import 'package:exam_a_app/feature/profile/domain/use_case/get_user_profile_use_case.dart';
import 'package:exam_a_app/feature/profile/presentation/view_model/states/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../domain/models/edit_profile_params.dart';

@injectable
class ProfileCubit extends Cubit<ProfileState> {
  final GetUserProfileUseCase _getUserProfileUseCase;
  final EditProfileUseCase _editProfileUseCase;
  final SecureStorage _secureStorage;
  final HiveStorageContract _hiveStorage;

  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  String? _lastLoadedUserId;

  ProfileCubit(
    this._getUserProfileUseCase,
    this._editProfileUseCase,
    this._secureStorage,
    this._hiveStorage,
  ) : super(const ProfileState()) {
    _addListeners();
  }

  void _checkForChanges() {
    if (state.user == null) return;

    final user = state.user!;
    final currentHasChanges =
        usernameController.text != user.username ||
        firstNameController.text != user.firstName ||
        lastNameController.text != user.lastName ||
        emailController.text != user.email ||
        phoneController.text != user.phone;

    if (currentHasChanges != state.hasChanges) {
      emit(state.copyWith(hasChanges: currentHasChanges));
    }
  }

  Future<void> logout() async {
    emit(state.copyWith(isLoggingOut: true));
    try {
      await _secureStorage.deleteToken(key: 'auth_token');
      await _hiveStorage.clearBox('exams_history');
      emit(state.copyWith(isLoggingOut: false, logoutSuccess: true));
    } catch (e) {
      emit(state.copyWith(isLoggingOut: false, logoutSuccess: false));
    }
  }

  Future<void> getProfile() async {
    emit(
      state.copyWith(
        status: ProfileStatus.loading,
        errorMessage: null,
        updateSuccess: false,
      ),
    );

    final response = await _getUserProfileUseCase();
    switch (response) {
      case SuccessResponse<UserDataModel>():
        emit(
          state.copyWith(status: ProfileStatus.success, user: response.data),
        );
        break;
      case ErrorResponse<UserDataModel>():
        emit(
          state.copyWith(
            status: ProfileStatus.error,
            errorMessage: response.errorMessage,
          ),
        );
        break;
    }
  }

  void fillControllers(UserDataModel user, {bool force = false}) {
    if (!force && _lastLoadedUserId == user.id) return;

    _removeListeners();

    usernameController.text = user.username;
    firstNameController.text = user.firstName;
    lastNameController.text = user.lastName;
    emailController.text = user.email;
    phoneController.text = user.phone;
    _lastLoadedUserId = user.id;

    _addListeners();

    if (state.hasChanges || state.updateSuccess) {
      emit(state.copyWith(hasChanges: false, updateSuccess: false));
    }
  }

  void _addListeners() {
    usernameController.addListener(_checkForChanges);
    firstNameController.addListener(_checkForChanges);
    lastNameController.addListener(_checkForChanges);
    emailController.addListener(_checkForChanges);
    phoneController.addListener(_checkForChanges);
  }

  void _removeListeners() {
    usernameController.removeListener(_checkForChanges);
    firstNameController.removeListener(_checkForChanges);
    lastNameController.removeListener(_checkForChanges);
    emailController.removeListener(_checkForChanges);
    phoneController.removeListener(_checkForChanges);
  }

  Future<void> editProfile(EditProfileParams params) async {
    emit(
      state.copyWith(
        isUpdating: true,
        updateErrorMessage: null,
        updateSuccess: false,
      ),
    );

    final response = await _editProfileUseCase(params);
    switch (response) {
      case SuccessResponse<UserDataModel>():
        emit(
          state.copyWith(
            isUpdating: false,
            user: response.data,
            updateSuccess: true,
          ),
        );
        break;
      case ErrorResponse<UserDataModel>():
        emit(
          state.copyWith(
            isUpdating: false,
            updateErrorMessage: response.errorMessage,
            updateSuccess: false,
          ),
        );
        break;
    }
  }

  Future<void> submitEditProfile() async {
    if (!(formKey.currentState?.validate() ?? false)) return;

    await editProfile(
      EditProfileParams(
        username: usernameController.text.trim(),
        firstName: firstNameController.text.trim(),
        lastName: lastNameController.text.trim(),
        email: emailController.text.trim(),
        phone: phoneController.text.trim(),
      ),
    );
  }

  @override
  Future<void> close() {
    _removeListeners();
    usernameController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    return super.close();
  }
}
