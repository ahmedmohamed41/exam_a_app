import 'package:exam_a_app/config/base_response/base_response.dart';
import 'package:exam_a_app/feature/auth/register/domain/model/register_details.dart';
import 'package:exam_a_app/feature/auth/register/domain/repo/register_repo_contract.dart';
import 'package:injectable/injectable.dart';
import '../model/register_params.dart';

@injectable
class RegisterUseCase {
  final RegisterRepoContract registerRepo;
  RegisterUseCase(this.registerRepo);

  Future<BaseResponse<RegisterDetails>> call(RegisterParams params) =>
      registerRepo.register(params);
}
