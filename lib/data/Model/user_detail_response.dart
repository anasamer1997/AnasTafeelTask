import 'package:anas_tafeel_task/data/Model/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_detail_response.g.dart';

@JsonSerializable()
class UserDetailResponse {
  final UserModel data;
  final Support support;

  UserDetailResponse({
    required this.data,
    required this.support,
  });

  factory UserDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$UserDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserDetailResponseToJson(this);
}

@JsonSerializable()
class Support {
  final String url;
  final String text;

  Support({
    required this.url,
    required this.text,
  });

  factory Support.fromJson(Map<String, dynamic> json) =>
      _$SupportFromJson(json);

  Map<String, dynamic> toJson() => _$SupportToJson(this);
}
