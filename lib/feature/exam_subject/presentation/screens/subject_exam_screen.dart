import 'package:exam_a_app/core/utils/color_manager.dart';
import 'package:exam_a_app/feature/exam_subject/presentation/view_model/cubit/exam_subject_cubit.dart';
import 'package:exam_a_app/feature/exam_subject/presentation/view_model/states/exam_subject_state.dart';
import 'package:exam_a_app/feature/exam_subject/presentation/widgets/custom_exam_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubjectExamScreen extends StatelessWidget {
  const SubjectExamScreen({super.key, required this.subjectId});
  final String subjectId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.whiteColor,
      appBar: AppBar(
        backgroundColor: ColorManager.whiteColor,
        elevation: 0,
        title: const Text(
          'Available Exams',
          style: TextStyle(
            color: ColorManager.blackColor,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: ColorManager.blackColor),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(
              'Select an exam to start your assessment',
              style: TextStyle(
                color: ColorManager.greyColor,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<ExamSubjectCubit, ExamSubjectState>(
              builder: (BuildContext context, ExamSubjectState state) {
                switch (state.status) {
                  case ExamSubjectStatus.loading:
                    return const Center(
                      child: CircularProgressIndicator(
                        color: ColorManager.primeColor,
                      ),
                    );
                  case ExamSubjectStatus.error:
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.error_outline,
                              size: 60,
                              color: ColorManager.errorColor,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              state.errorMessage ?? 'An error occurred',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: ColorManager.greyColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  case ExamSubjectStatus.success:
                    if (state.exams == null || state.exams!.isEmpty) {
                      return const Center(
                        child: Text(
                          'No exams available for this subject',
                          style: TextStyle(color: ColorManager.greyColor),
                        ),
                      );
                    }
                    return ListView.builder(
                      padding: const EdgeInsets.only(bottom: 24),
                      itemBuilder: (context, index) =>
                          CustomExamCard(examSubjectModel: state.exams![index]),
                      itemCount: state.exams!.length,
                    );
                  case ExamSubjectStatus.initial:
                    return const SizedBox.shrink();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
