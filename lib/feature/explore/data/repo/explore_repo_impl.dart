import 'package:exam_a_app/config/base_response/base_response.dart';
import 'package:exam_a_app/core/utils/error_handler.dart';
import 'package:exam_a_app/feature/explore/data/data_source/explore_remote_datasource.dart';
import 'package:exam_a_app/feature/explore/domain/model/subject_entity.dart';
import 'package:exam_a_app/feature/explore/domain/repo/explore_repo_contract.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ExploreRepo)
class ExploreRepoImp implements ExploreRepo {
  final ExploreRemoteDatasource _exploreDataSource;

  ExploreRepoImp(this._exploreDataSource);

  @override
  Future<BaseResponse<List<SubjectEntity>>> getAllSubjects() async {
    try {
      final result = await _exploreDataSource.getAllSubject();
      return SuccessResponse<List<SubjectEntity>>(
        data: result.map((dto) => dto.toEntity()).toList(),
      );
    } catch (e) {
      return ErrorResponse<List<SubjectEntity>>(
        errorMessage: ErrorHandler.handle(e),
      );
    }
  }
}
