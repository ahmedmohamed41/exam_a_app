import 'package:dio/dio.dart';
import 'package:exam_a_app/core/constant/app_endpoints.dart';
import 'package:exam_a_app/feature/explore/data/model/subject_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'explore_services.g.dart';

@lazySingleton
@RestApi()
abstract class ExploreService {
  @factoryMethod
  factory ExploreService(Dio dio) = _ExploreService;

  @GET(AppEndPoints.subjectEndpoint)
  Future<SubjectsResponseModel> getAllSubjects();
}
