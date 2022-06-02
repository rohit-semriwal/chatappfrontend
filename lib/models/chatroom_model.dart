import 'package:chatappfrontend/models/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chatroom_model.g.dart';

@JsonSerializable()
class ChatroomModel {
  String? chatroomid;
  List<UserModel>? participants;
  dynamic lastmessage;
  DateTime? createdon;

  ChatroomModel({ this.chatroomid, this.participants, this.lastmessage, this.createdon });

  factory ChatroomModel.fromJson(Map<String, dynamic> map) => _$ChatroomModelFromJson(map);

  Map<String, dynamic> toJson() => _$ChatroomModelToJson(this);
}