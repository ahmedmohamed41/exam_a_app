import 'package:exam_a_app/config/base_response/base_response.dart';
import 'package:exam_a_app/feature/auth/forget_password/domain/models/forget_password_model.dart';
import 'package:exam_a_app/feature/auth/forget_password/domain/use_case/forget_password_use_case.dart';
import 'package:exam_a_app/feature/auth/forget_password/presentation/view_model/states/forget_password_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  final ForgetPasswordUseCase _forgetPasswordUseCase;

  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  ForgetPasswordCubit(this._forgetPasswordUseCase)
      : super(const ForgetPasswordState());

  Future<void> forgetPassword() async {
    if (!formKey.currentState!.validate()) return;

    emit(state.copyWith(status: ForgetPasswordStatus.loading, errorMessage: null));

    final response = await _forgetPasswordUseCase(email: emailController.text);

    switch (response) {
      case SuccessResponse<ForgetPasswordModel>():
        emit(state.copyWith(
          status: ForgetPasswordStatus.success,
          result: response.data,
        ));
        break;
      case ErrorResponse<ForgetPasswordModel>():
        emit(state.copyWith(
          status: ForgetPasswordStatus.error,
          errorMessage: response.errorMessage,
        ));
        break;
    }
  }

  @override
  Future<void> close() {
    emailController.dispose();
    return super.close();
  }
}
