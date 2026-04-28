import 'package:exam_a_app/feature/explore/api/services/explore_services.dart';
import 'package:exam_a_app/feature/explore/data/data_source/explore_remote_datasource.dart';
import 'package:exam_a_app/feature/explore/data/model/subject_model_dto.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ExploreRemoteDatasource)
class ExploreRemoteDataSourceImpl implements ExploreRemoteDatasource {
  final ExploreService exploreService;

  ExploreRemoteDataSourceImpl(this.exploreService);

  @override
  Future<List<SubjectModelDto>> getAllSubject() async {
    final response = await exploreService.getAllSubjects();
    return response.subjects ?? [];
  }
}
