import 'package:equatable/equatable.dart';

enum ResetPasswordStatus { initial, loading, success, error }

class ResetPasswordState extends Equatable {
  final ResetPasswordStatus status;
  final String? errorMessage;
  final bool isObscure;

  const ResetPasswordState({
    this.status = ResetPasswordStatus.initial,
    this.errorMessage,
    this.isObscure = true,
  });

  ResetPasswordState copyWith({
    ResetPasswordStatus? status,
    String? errorMessage,
    bool? isObscure,
  }) {
    return ResetPasswordState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      isObscure: isObscure ?? this.isObscure,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage, isObscure];
}
