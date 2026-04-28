import 'package:exam_a_app/config/base_response/base_response.dart';
import 'package:exam_a_app/feature/auth/register/domain/useCases/register_use_case.dart';
import 'package:exam_a_app/feature/auth/register/presentation/viewModel/register_intent.dart';
import 'package:exam_a_app/feature/auth/register/presentation/viewModel/register_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../domain/model/register_params.dart';

@injectable
class RegisterCubit extends Cubit<RegisterState> {
  final RegisterUseCase registerUseCase;

  RegisterCubit(this.registerUseCase) : super(const RegisterState());

  void doIntent(RegisterIntent intent) {
    switch (intent) {
      case DoRegisterIntent():
        _register(intent);
        break;
    }
  }

  Future<void> _register(DoRegisterIntent intent) async {
    emit(state.copyWith(status: RegisterStatus.loading, errorMessage: null));

    final params = RegisterParams(
      firstName: intent.firstName,
      lastName: intent.lastName,
      username: intent.username,
      email: intent.email,
      phone: intent.phone,
      password: intent.password,
      rePassword: intent.confirmPassword,
    );

    final result = await registerUseCase(params);

    switch (result) {
      case SuccessResponse():
        emit(state.copyWith(status: RegisterStatus.success, result: result.data));
      case ErrorResponse():
        emit(state.copyWith(
          status: RegisterStatus.error,
          errorMessage: result.errorMessage,
        ));
    }
  }
}
