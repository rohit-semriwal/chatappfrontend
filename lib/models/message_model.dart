// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'message_model.g.dart';

@JsonSerializable()
class MessageModel extends Equatable {
  String? id;
  String? messageid;
  String? chatroomid;
  String? msg;
  String? sender;
  DateTime? createdon;

  MessageModel({ this.id, this.messageid, this.chatroomid, this.msg, this.sender, this.createdon });

  factory MessageModel.fromJson(Map<String, dynamic> map) => _$MessageModelFromJson(map);

  Map<String, dynamic> toJson() => _$MessageModelToJson(this);

  @override
  List<Object?> get props => [ messageid ];
}