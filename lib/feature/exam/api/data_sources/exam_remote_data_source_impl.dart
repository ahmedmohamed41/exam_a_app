import 'package:injectable/injectable.dart';

import '../../data/data_sources/exam_remote_data_source_contract.dart';
import '../../data/models/exam_dto.dart';
import '../exam_api_client/exam_api_client.dart';

@Injectable(as: ExamRemoteDataSourceContract)
class ExamRemoteDataSourceImpl implements ExamRemoteDataSourceContract {
  final ExamApiClient _apiClient;

  ExamRemoteDataSourceImpl(this._apiClient);

  @override
  Future<ExamResponseDto> getExamQuestions(String examId) async {
    return await _apiClient.getExamQuestions(examId);
  }
}
