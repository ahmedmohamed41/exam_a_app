import 'package:exam_a_app/core/utils/router/app_routes.dart';
import 'package:exam_a_app/core/utils/widgets/custom_app_bar.dart';
import 'package:exam_a_app/core/utils/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, title: 'Home Screen'),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomButton(
            title: 'Navigator to Subject Exam',
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.subjectExamScreen);
            },
            isEnabled: true,
          ),
        ],
      ),
    );
  }
}
