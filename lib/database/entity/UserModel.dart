// ignore: file_names
import 'package:json_annotation/json_annotation.dart';

part 'UserModel.g.dart';

@JsonSerializable()
class UserModel {
  UserModel(
    this.name,
    this.email,
    this.mobileNumber,
    this.password,
    this.loginid,
  );

  String name;
  String email;
  String mobileNumber;
  String password;
  String loginid;
  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
