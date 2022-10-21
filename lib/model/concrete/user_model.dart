import 'package:flutter_login_sample/model/base/i_base_model.dart';
import 'package:json_annotation/json_annotation.dart';

/// Created by Yunus Emre Yıldırım
/// on 18.10.2022

part 'user_model.g.dart';

@JsonSerializable()
class UserModel implements IBaseModel {
  String? id;
  String email;
  String? password;

  UserModel({required this.id, required this.email, required this.password});

  UserModel.withoutId({required this.email, required this.password});

  UserModel.withoutPassword({required this.id, required this.email});

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
