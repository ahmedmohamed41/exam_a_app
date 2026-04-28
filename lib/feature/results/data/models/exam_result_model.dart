import 'package:json_annotation/json_annotation.dart';
import '../../domain/models/exam_result_entity.dart';
import '../../../exam/data/models/exam_dto.dart';

part 'exam_result_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ExamResultModel {
  final String uid;
  final int score;
  final int total;
  final DateTime date;
  final String? examTitle;
  final String? subjectId;
  final String? subjectName;
  final String? subjectIcon;
  final List<QuestionDto> questions;
  final Map<String, List<String>> userAnswers;

  ExamResultModel({
    required this.uid,
    required this.score,
    required this.total,
    required this.date,
    this.examTitle,
    this.subjectId,
    this.subjectName,
    this.subjectIcon,
    required this.questions,
    required this.userAnswers,
  });

  factory ExamResultModel.fromEntity(ExamResultEntity entity) {
    return ExamResultModel(
      uid: entity.uid,
      score: entity.score,
      total: entity.total,
      date: entity.date,
      examTitle: entity.examTitle,
      subjectId: entity.subjectId,
      subjectName: entity.subjectName,
      subjectIcon: entity.subjectIcon,
      questions: entity.questions.map((q) => QuestionDto.fromEntity(q)).toList(),
      userAnswers: entity.userAnswers.map((key, value) => MapEntry(key.toString(), value)),
    );
  }

  ExamResultEntity toEntity() {
    return ExamResultEntity(
      uid: uid,
      score: score,
      total: total,
      date: date,
      examTitle: examTitle,
      subjectId: subjectId,
      subjectName: subjectName,
      subjectIcon: subjectIcon,
      questions: questions.map((q) => q.toEntity()).toList(),
      userAnswers: userAnswers.map((key, value) => MapEntry(int.parse(key), value)),
    );
  }

  factory ExamResultModel.fromJson(Map<String, dynamic> json) =>
      _$ExamResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$ExamResultModelToJson(this);
}
