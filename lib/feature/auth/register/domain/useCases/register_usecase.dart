import 'package:exam_a_app/config/base_response/base_response.dart';
import 'package:exam_a_app/feature/auth/register/data/model/register_request.dart';
import 'package:exam_a_app/feature/auth/register/domain/model/user_model.dart';
import 'package:exam_a_app/feature/auth/register/domain/repo/register_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class RegisterUsecase {
  final RegisterRepoContract registerRepo;
  RegisterUsecase(this.registerRepo);
  Future<BaseResponse<RegisterModel>> call(RegisterRequest request) async {
    final result = await registerRepo.register(request);
    return result;
  }
}
