// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      json['name'] as String,
      json['email'] as String,
      json['mobileNumber'] as String,
      json['password'] as String,
      json['loginid'] as String,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'mobileNumber': instance.mobileNumber,
      'password': instance.password,
      'loginid': instance.loginid,
    };
