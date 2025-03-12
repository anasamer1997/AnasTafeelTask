import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  @JsonKey(name: "id", defaultValue: 0)
  final int id;
  @JsonKey(name: "email", defaultValue: "")
  final String email;
  @JsonKey(name: "first_name", defaultValue: "")
  final String firstName;
  @JsonKey(name: "last_name", defaultValue: "")
  final String lastName;
  @JsonKey(name: "avatar", defaultValue: "")
  final String avatar;

  UserModel(
      {required this.id,
      required this.email,
      required this.firstName,
      required this.lastName,
      required this.avatar});

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
