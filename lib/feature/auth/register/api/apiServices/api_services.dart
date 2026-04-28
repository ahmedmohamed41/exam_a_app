import 'package:dio/dio.dart';
import 'package:exam_a_app/core/constant/app_endpoints.dart';
import 'package:exam_a_app/feature/auth/register/data/model/register_request.dart';
import 'package:exam_a_app/feature/auth/register/data/model/register_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'api_services.g.dart';

@lazySingleton
@RestApi()
abstract class RegisterApiService {
  @factoryMethod
  factory RegisterApiService(Dio dio) = _RegisterApiService;

  @POST(AppEndPoints.register)
  Future<RegisterResponse> register(@Body() RegisterRequest request);
}
