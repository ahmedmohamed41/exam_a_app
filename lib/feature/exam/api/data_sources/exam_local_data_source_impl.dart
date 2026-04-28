import 'package:exam_a_app/core/storage/hive_storage_contract.dart';
import 'package:injectable/injectable.dart';
import '../../../results/data/models/exam_result_model.dart';
import '../../../results/domain/models/exam_result_entity.dart';
import '../../data/data_sources/exam_local_data_source_contract.dart';

@Injectable(as: ExamLocalDataSourceContract)
class ExamLocalDataSourceImpl implements ExamLocalDataSourceContract {
  final HiveStorageContract _hiveStorage;

  ExamLocalDataSourceImpl(this._hiveStorage);

  @override
  Future<void> saveExamResult(ExamResultEntity result) async {
    final model = ExamResultModel.fromEntity(result);
    await _hiveStorage.saveData('exams_history', result.uid, model.toJson());
  }
}
