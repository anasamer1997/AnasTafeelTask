import 'package:anas_tafeel_task/data/Model/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_list_response.g.dart';

@JsonSerializable()
class UserListResponse {
  final int page;
  final int per_page;
  final int total;
  final int total_pages;
  final List<UserModel> data;

  UserListResponse({
    required this.page,
    required this.per_page,
    required this.total,
    required this.total_pages,
    required this.data,
  });

  factory UserListResponse.fromJson(Map<String, dynamic> json) =>
      _$UserListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserListResponseToJson(this);
}
