import 'package:equatable/equatable.dart';
import 'package:exam_a_app/feature/profile/domain/models/user_data_model.dart';

enum ProfileStatus { initial, loading, success, error }

class ProfileState extends Equatable {
  final ProfileStatus status;
  final UserDataModel? user;
  final String? errorMessage;

  final bool isUpdating;
  final String? updateErrorMessage;
  final bool updateSuccess;

  final bool hasChanges;
  final bool isLoggingOut;
  final bool logoutSuccess;

  const ProfileState({
    this.status = ProfileStatus.initial,
    this.user,
    this.errorMessage,
    this.isUpdating = false,
    this.updateErrorMessage,
    this.updateSuccess = false,
    this.hasChanges = false,
    this.isLoggingOut = false,
    this.logoutSuccess = false,
  });

  ProfileState copyWith({
    ProfileStatus? status,
    UserDataModel? user,
    String? errorMessage,
    bool? isUpdating,
    String? updateErrorMessage,
    bool? updateSuccess,
    bool? hasChanges,
    bool? isLoggingOut,
    bool? logoutSuccess,
  }) {
    return ProfileState(
      status: status ?? this.status,
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
      isUpdating: isUpdating ?? this.isUpdating,
      updateErrorMessage: updateErrorMessage ?? this.updateErrorMessage,
      updateSuccess: updateSuccess ?? this.updateSuccess,
      hasChanges: hasChanges ?? this.hasChanges,
      isLoggingOut: isLoggingOut ?? this.isLoggingOut,
      logoutSuccess: logoutSuccess ?? this.logoutSuccess,
    );
  }

  @override
  List<Object?> get props => [
    status,
    user,
    errorMessage,
    isUpdating,
    updateErrorMessage,
    updateSuccess,
    hasChanges,
    isLoggingOut,
    logoutSuccess,
  ];
}
