import 'package:exam_a_app/core/presentation/error_page/error_page.dart';
import 'package:exam_a_app/core/utils/router/app_routes.dart';
import 'package:exam_a_app/feature/auth/forget_password/presentation/screens/forget_password_screen.dart';
import 'package:exam_a_app/feature/auth/forget_password/presentation/screens/reset_password_screen.dart';
import 'package:exam_a_app/feature/auth/forget_password/presentation/screens/verification_code_screen.dart';
import 'package:exam_a_app/feature/auth/register/presentation/screens/register_screen.dart';
import 'package:exam_a_app/feature/exam/presentation/Bloc/exam_bloc.dart';
import 'package:exam_a_app/feature/exam/presentation/screens/exam_page.dart';
import 'package:exam_a_app/feature/exam/presentation/screens/score_page.dart';
import 'package:exam_a_app/feature/explore/presentation/screens/explore_screen.dart';
import 'package:exam_a_app/feature/exam_subject/domain/models/exam_subject_model.dart';
import 'package:exam_a_app/feature/exam_subject/presentation/screens/subject_exam_details_screen.dart';
import 'package:exam_a_app/feature/profile/presentation/screens/profile_screen.dart';
import 'package:exam_a_app/feature/exam_subject/presentation/screens/subject_exam_screen.dart';
import 'package:exam_a_app/feature/exam_subject/presentation/view_model/cubit/exam_subject_cubit.dart';
import 'package:exam_a_app/feature/profile_change_password/presentation/screens/change_password_screen.dart';
import 'package:exam_a_app/feature/results/domain/models/exam_result_entity.dart';
import 'package:exam_a_app/feature/results/presentation/screens/results_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/di/di.dart';
import '../../../feature/auth/forget_password/presentation/view_model/cubit/forget_password_cubit.dart';
import '../../../feature/auth/forget_password/presentation/view_model/cubit/reset_password_cubit.dart';
import '../../../feature/auth/forget_password/presentation/view_model/cubit/verification_cubit.dart';
import '../../../feature/auth/login/presentation/Bloc/login_bloc.dart';
import '../../../feature/auth/login/presentation/screens/login_screen.dart';

class RoutesManager {
  static Route? router(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.forgetPasswordScreen:
        return _buildForgetPasswordRoute();
      case AppRoutes.verificationCodeScreen:
        return _buildVerificationRoute(settings);
      case AppRoutes.resetPasswordScreen:
        return _buildResetPasswordRoute(settings);
      case AppRoutes.login:
        return _buildLoginRoute();
      case AppRoutes.register:
        return _buildRegisterRoute();
      case AppRoutes.exam:
        return _buildExamRoute(settings);
      case AppRoutes.score:
        return _buildScoreRoute(settings);
      case AppRoutes.subjectExamDetailsScreen:
        return _buildSubjectExamDetailsRoute(settings);
      case AppRoutes.explore:
        return CupertinoPageRoute(builder: (context) => const ExplorePage());
      case AppRoutes.profile:
        return CupertinoPageRoute(builder: (context) => const ProfileScreen());
      case AppRoutes.subjectExamScreen:
        return _buildSubjectExamRoute(settings);
      case AppRoutes.changePassword:
        return CupertinoPageRoute(
          builder: (context) => const ChangePasswordScreen(),
        );
      case AppRoutes.results:
        return CupertinoPageRoute(builder: (context) => const ResultsScreen());
      default:
        return CupertinoPageRoute(
          builder: (context) =>
              ErrorPage(errorMessage: "No route defined for ${settings.name}"),
        );
    }
  }

  static Route _buildForgetPasswordRoute() {
    return CupertinoPageRoute(
      builder: (context) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => getIt<ForgetPasswordCubit>()),
          BlocProvider(create: (_) => getIt<VerificationCubit>()),
          BlocProvider(create: (_) => getIt<ResetPasswordCubit>()),
        ],
        child: ForgetPasswordScreen(),
      ),
    );
  }

  static Route _buildVerificationRoute(RouteSettings settings) {
    if (settings.arguments is! String)
      return _errorRoute("Invalid email argument");
    final email = settings.arguments as String;
    return CupertinoPageRoute(
      builder: (context) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => getIt<ForgetPasswordCubit>()),
          BlocProvider(create: (_) => getIt<VerificationCubit>()),
          BlocProvider(create: (_) => getIt<ResetPasswordCubit>()),
        ],
        child: VerificationCodeScreen(email: email),
      ),
    );
  }

  static Route _buildResetPasswordRoute(RouteSettings settings) {
    if (settings.arguments is! String)
      return _errorRoute("Invalid email argument");
    final email = settings.arguments as String;
    return CupertinoPageRoute(
      builder: (context) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => getIt<ForgetPasswordCubit>()),
          BlocProvider(create: (_) => getIt<VerificationCubit>()),
          BlocProvider(create: (_) => getIt<ResetPasswordCubit>()),
        ],
        child: ResetPasswordScreen(email: email),
      ),
    );
  }

  static Route _buildLoginRoute() {
    return CupertinoPageRoute(
      builder: (context) => BlocProvider(
        create: (_) => getIt<LoginBloc>(),
        child: const LoginScreen(),
      ),
    );
  }

  static Route _buildRegisterRoute() {
    return CupertinoPageRoute(builder: (context) => const RegisterScreen());
  }

  static Route _buildExamRoute(RouteSettings settings) {
    if (settings.arguments is! String)
      return _errorRoute("Invalid examId argument");
    final examId = settings.arguments as String;
    return CupertinoPageRoute(
      builder: (context) => BlocProvider(
        create: (_) => getIt<ExamBloc>(),
        child: ExamPage(examId: examId),
      ),
    );
  }

  static Route _buildScoreRoute(RouteSettings settings) {
    if (settings.arguments is! Map<String, dynamic>)
      return _errorRoute("Invalid score arguments");
    final args = settings.arguments as Map<String, dynamic>;
    return CupertinoPageRoute(
      builder: (context) => ScorePage(
        score: args['score'] as int? ?? 0,
        total: args['total'] as int? ?? 0,
        examId: args['examId'] as String?,
        result: args['result'] as ExamResultEntity?,
      ),
    );
  }

  static Route _buildSubjectExamDetailsRoute(RouteSettings settings) {
    if (settings.arguments is! ExamSubjectModel)
      return _errorRoute("Invalid ExamSubjectModel argument");
    final modal = settings.arguments as ExamSubjectModel;
    return CupertinoPageRoute(
      builder: (context) => SubjectExamDetailsScreen(modal: modal),
    );
  }

  static Route _buildSubjectExamRoute(RouteSettings settings) {
    if (settings.arguments is! String)
      return _errorRoute("Invalid subjectId argument");
    final subjectId = settings.arguments as String;
    return CupertinoPageRoute(
      builder: (context) => BlocProvider(
        create: (_) => getIt<ExamSubjectCubit>()..getExams(subjectId),
        child: SubjectExamScreen(subjectId: subjectId),
      ),
    );
  }

  static Route _errorRoute(String message) {
    return CupertinoPageRoute(
      builder: (context) => ErrorPage(errorMessage: message),
    );
  }
}
