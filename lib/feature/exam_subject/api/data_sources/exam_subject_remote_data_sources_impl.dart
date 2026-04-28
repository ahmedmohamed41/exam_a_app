import 'dart:async';
import 'package:dio/dio.dart';
import 'package:exam_a_app/config/base_response/base_response.dart';
import 'package:exam_a_app/feature/exam_subject/api/exam_subject_api_client/exam_subject_api_client.dart';
import 'package:exam_a_app/feature/exam_subject/data/data_sources/exam_subject_remote_data_sources_contract.dart';
import 'package:exam_a_app/feature/exam_subject/data/models/exam_subject_dto.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ExamSubjectRemoteDataSourcesContract)
class ExamSubjectRemoteDataSourcesImpl
    implements ExamSubjectRemoteDataSourcesContract {
  final ExamSubjectApiClient examSubjectApiClient;

  ExamSubjectRemoteDataSourcesImpl(this.examSubjectApiClient);
  @override
  Future<BaseResponse<List<ExamSubjectDto>>> getExams(String? subjectId) async {
    try {
      final response = await examSubjectApiClient.getExamsOnSubject(
        subjectId: subjectId ?? '',
      );
      return SuccessResponse<List<ExamSubjectDto>>(data: response.exams ?? []);
    } catch (e) {
      if (e is DioException) {
        return ErrorResponse<List<ExamSubjectDto>>(
          errorMessage: e.message ?? 'Dio Exception',
        );
      } else if (e is TimeoutException) {
        return ErrorResponse<List<ExamSubjectDto>>(
          errorMessage: e.message ?? 'Request Time out ,Please try again later',
        );
      }
      return ErrorResponse<List<ExamSubjectDto>>(
        errorMessage: 'Something went wrong ,Please try again later',
      );
    }
  }
}
