import '../../../results/domain/models/exam_result_entity.dart';

abstract interface class ExamLocalDataSourceContract {
  Future<void> saveExamResult(ExamResultEntity result);
}
