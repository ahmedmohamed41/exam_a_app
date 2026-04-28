import 'package:equatable/equatable.dart';
import 'package:exam_a_app/feature/exam_subject/domain/models/exam_subject_model.dart';

enum ExamSubjectStatus { initial, loading, success, error }

class ExamSubjectState extends Equatable {
  final ExamSubjectStatus status;
  final List<ExamSubjectModel>? exams;
  final String? errorMessage;

  const ExamSubjectState({
    this.status = ExamSubjectStatus.initial,
    this.exams,
    this.errorMessage,
  });

  ExamSubjectState copyWith({
    ExamSubjectStatus? status,
    List<ExamSubjectModel>? exams,
    String? errorMessage,
  }) {
    return ExamSubjectState(
      status: status ?? this.status,
      exams: exams ?? this.exams,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, exams, errorMessage];
}
