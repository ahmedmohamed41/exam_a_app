import 'package:injectable/injectable.dart';
import '../../../results/domain/models/exam_result_entity.dart';
import '../repo/exam_repo_contract.dart';

@injectable
class StoreExamResultUseCase {
  final ExamRepoContract _repository;

  StoreExamResultUseCase(this._repository);

  Future<void> call(ExamResultEntity result) async {
    return await _repository.saveExamResult(result);
  }
}
