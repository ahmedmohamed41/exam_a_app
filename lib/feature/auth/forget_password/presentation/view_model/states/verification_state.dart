import 'package:equatable/equatable.dart';
import 'package:exam_a_app/feature/auth/forget_password/data/models/verify_reset_code_dto.dart';

enum VerificationStatus { initial, loading, success, error }

class VerificationState extends Equatable {
  final VerificationStatus status;
  final VerifyResetCodeDto? result;
  final String? errorMessage;

  const VerificationState({
    this.status = VerificationStatus.initial,
    this.result,
    this.errorMessage,
  });

  VerificationState copyWith({
    VerificationStatus? status,
    VerifyResetCodeDto? result,
    String? errorMessage,
  }) {
    return VerificationState(
      status: status ?? this.status,
      result: result ?? this.result,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, result, errorMessage];
}
