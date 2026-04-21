import 'package:exam_a_app/config/base_response/base_response.dart';
import 'package:exam_a_app/feature/exam_subject/data/models/exam_subject_dto.dart';

abstract class ExamSubjectRemoteDataSourcesContract {
  Future<BaseResponse<List<ExamSubjectDto>>> getExams(String? subjectId);
}
