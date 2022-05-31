import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  String? id;
  String? userid;
  String? fullname;
  String? email;
  String? password;
  String? createdon;

  UserModel({ this.id, this.userid, this.fullname, this.email, this.password, this.createdon });

  factory UserModel.fromJson(Map<String, dynamic> map) => _$UserModelFromJson(map);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}