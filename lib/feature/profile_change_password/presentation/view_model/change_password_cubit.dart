import 'package:exam_a_app/config/base_response/base_response.dart';
import 'package:exam_a_app/feature/profile_change_password/domain/usecase/change_password_use_case.dart';
import 'package:exam_a_app/feature/profile_change_password/presentation/view_model/change_password_intent.dart';
import 'package:exam_a_app/feature/profile_change_password/presentation/view_model/change_password_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ChangePasswordCubit
    extends Bloc<ChangePasswordIntent, ChangePasswordState> {
  final ChangePasswordUseCase _changePasswordUseCase;

  ChangePasswordCubit(this._changePasswordUseCase)
    : super(const ChangePasswordState()) {
    on<ChangePasswordIntent>(_onIntent);
  }

  Future<void> _onIntent(
    ChangePasswordIntent intent,
    Emitter<ChangePasswordState> emit,
  ) async {
    switch (intent) {
      case ChangePasswordButtonPressed():
        await _changePassword(emit, intent);
        break;
    }
  }

  Future<void> _changePassword(
    Emitter<ChangePasswordState> emit,
    ChangePasswordButtonPressed intent,
  ) async {
    emit(
      state.copyWith(status: ChangePasswordStatus.loading, errorMessage: null),
    );

    final result = await _changePasswordUseCase(
      oldPassword: intent.oldPassword,
      password: intent.password,
      rePassword: intent.rePassword,
    );

    switch (result) {
      case SuccessResponse():
        emit(
          state.copyWith(
            status: ChangePasswordStatus.success,
            result: result.data,
          ),
        );
        break;
      case ErrorResponse():
        emit(
          state.copyWith(
            status: ChangePasswordStatus.error,
            errorMessage: result.errorMessage,
          ),
        );
        break;
    }
  }
}
