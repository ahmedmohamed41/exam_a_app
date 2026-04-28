import 'package:equatable/equatable.dart';
import 'package:exam_a_app/feature/profile_change_password/domain/model/change_password_details.dart';

enum ChangePasswordStatus { initial, loading, success, error }

class ChangePasswordState extends Equatable {
  final ChangePasswordStatus status;
  final ChangePasswordDetails? result;
  final String? errorMessage;

  const ChangePasswordState({
    this.status = ChangePasswordStatus.initial,
    this.result,
    this.errorMessage,
  });

  ChangePasswordState copyWith({
    ChangePasswordStatus? status,
    ChangePasswordDetails? result,
    String? errorMessage,
  }) {
    return ChangePasswordState(
      status: status ?? this.status,
      result: result ?? this.result,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, result, errorMessage];
}
