import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../config/base_response/base_response.dart';
import '../../domain/usecases/login_usecase.dart';
import 'login_event.dart';
import 'login_state.dart';

@injectable
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase loginUseCase;

  LoginBloc(this.loginUseCase) : super(LoginState.initial()) {
    on<LoginSubmitted>(_login);
  }

  Future<void> _login(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(status: LoginStatus.loading, errorMessage: null));

    final result = await loginUseCase(
      event.email,
      event.password,
      rememberMe: event.rememberMe,
    );

    switch (result) {
      case SuccessResponse():
        emit(state.copyWith(
          status: LoginStatus.success,
          result: result.data,
        ));
      case ErrorResponse():
        emit(state.copyWith(
          status: LoginStatus.error,
          errorMessage: result.errorMessage,
        ));
    }
  }
}
