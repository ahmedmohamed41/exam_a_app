import 'package:equatable/equatable.dart';
import 'package:exam_a_app/feature/auth/forget_password/domain/models/forget_password_model.dart';

enum ForgetPasswordStatus { initial, loading, success, error }

class ForgetPasswordState extends Equatable {
  final ForgetPasswordStatus status;
  final ForgetPasswordModel? result;
  final String? errorMessage;

  const ForgetPasswordState({
    this.status = ForgetPasswordStatus.initial,
    this.result,
    this.errorMessage,
  });

  ForgetPasswordState copyWith({
    ForgetPasswordStatus? status,
    ForgetPasswordModel? result,
    String? errorMessage,
  }) {
    return ForgetPasswordState(
      status: status ?? this.status,
      result: result ?? this.result,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, result, errorMessage];
}
