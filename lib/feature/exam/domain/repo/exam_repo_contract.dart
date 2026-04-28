import '../../../../config/base_response/base_response.dart';
import '../../../results/domain/models/exam_result_entity.dart';
import '../models/exam_model.dart';

abstract interface class ExamRepoContract {
  Future<BaseResponse<ExamDetails>> getExamQuestions(String examId);
  Future<void> saveExamResult(ExamResultEntity result);
}
