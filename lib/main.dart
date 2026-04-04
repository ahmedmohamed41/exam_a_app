import 'package:exam_a_app/config/di/di.dart';
import 'package:exam_a_app/core/theme_manager.dart';
import 'package:exam_a_app/core/utils/router/app_routes.dart';
import 'package:exam_a_app/core/utils/router/router.dart';
import 'package:flutter/material.dart';


void main() {
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeManager.light,
      initialRoute: AppRoutes.homeScreen,
      onGenerateRoute: (settings) => RoutesManager.router(settings),
    );
  }
}