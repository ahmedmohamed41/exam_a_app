import 'package:exam_a_app/feature/explore/data/model/subject_model_dto.dart';

abstract interface class ExploreRemoteDatasource {
  Future<List<SubjectModelDto>> getAllSubject();
}
