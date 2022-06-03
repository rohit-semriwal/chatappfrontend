// ignore_for_file: must_be_immutable
import 'package:chatappfrontend/models/message_model.dart';
import 'package:chatappfrontend/models/user_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chatroom_model.g.dart';

@JsonSerializable()
class ChatroomModel extends Equatable {
  String? chatroomid;
  List<UserModel>? participants;
  MessageModel? lastmessage;
  DateTime? createdon;

  ChatroomModel({ this.chatroomid, this.participants, this.lastmessage, this.createdon });

  factory ChatroomModel.fromJson(Map<String, dynamic> map) => _$ChatroomModelFromJson(map);

  Map<String, dynamic> toJson() => _$ChatroomModelToJson(this);

  @override
  List<Object?> get props => [ chatroomid ];
}