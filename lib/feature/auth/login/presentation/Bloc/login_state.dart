import 'package:equatable/equatable.dart';
import '../../domain/entities/user_entity.dart';

enum LoginStatus { initial, loading, success, error }

class LoginState extends Equatable {
  final LoginStatus status;
  final (User, String)? result;
  final String? errorMessage;

  const LoginState({
    this.status = LoginStatus.initial,
    this.result,
    this.errorMessage,
  });

  factory LoginState.initial() => const LoginState();

  LoginState copyWith({
    LoginStatus? status,
    (User, String)? result,
    String? errorMessage,
  }) {
    return LoginState(
      status: status ?? this.status,
      result: result ?? this.result,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, result, errorMessage];
}
