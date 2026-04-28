import 'package:exam_a_app/config/base_response/base_response.dart';
import 'package:exam_a_app/feature/explore/domain/model/subject_entity.dart';
import 'package:exam_a_app/feature/explore/domain/repo/explore_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class SubjectsUseCase {
  final ExploreRepo _exploreRepo;
  SubjectsUseCase(this._exploreRepo);

  Future<BaseResponse<List<SubjectEntity>>> call() =>
      _exploreRepo.getAllSubjects();
}
