// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends Equatable {
  String? id;
  String? userid;
  String? fullname;
  String? email;
  String? password;
  String? createdon;

  UserModel({ this.id, this.userid, this.fullname, this.email, this.password, this.createdon });

  factory UserModel.fromJson(Map<String, dynamic> map) => _$UserModelFromJson(map);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  @override
  List<Object?> get props => [ userid ];
}