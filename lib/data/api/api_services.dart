import 'package:anas_tafeel_task/constent/constants.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../Model/user_detail_response.dart';
import '../Model/user_list_response.dart';

part 'api_services.g.dart';

@RestApi(baseUrl: "https://reqres.in/api/") // Ensure no invisible characters
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET(Endpoint.getUsers)
  Future<UserListResponse> getUsers(@Query("page") int page);

  @GET(Endpoint.getUser)
  Future<UserDetailResponse> getUserDetails(@Path("userId") int id);
}
