import 'package:injectable/injectable.dart';
import '../../data/data_sources/results_remote_data_source_contract.dart';
import '../results_api_client/results_api_client.dart';

@Injectable(as: ResultsRemoteDataSourceContract)
class ResultsRemoteDataSourceImpl implements ResultsRemoteDataSourceContract {
  final ResultsApiClient _apiClient;

  ResultsRemoteDataSourceImpl(this._apiClient);

  @override
  Future<SubjectResponse> getSubjectById(String id) async {
    return await _apiClient.getSubjectById(id);
  }
}
