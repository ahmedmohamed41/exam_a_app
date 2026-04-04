import 'package:exam_a_app/config/base_response/base_response.dart';
import 'package:exam_a_app/feature/exam_subject/domain/models/exam_subject_model.dart';

abstract class ExamSubjectRepoContract {
  Future<BaseResponse<List<ExamSubjectModel>>> getExams(String? subjectId);
}
