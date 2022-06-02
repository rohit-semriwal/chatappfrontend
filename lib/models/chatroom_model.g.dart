// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chatroom_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatroomModel _$ChatroomModelFromJson(Map<String, dynamic> json) =>
    ChatroomModel(
      chatroomid: json['chatroomid'] as String?,
      participants: (json['participants'] as List<dynamic>).map((userMap) {
        return UserModel.fromJson(userMap);
      }).toList(),
      lastmessage: json['lastmessage'],
      createdon: json['createdon'] == null
          ? null
          : DateTime.parse(json['createdon'] as String),
    );

Map<String, dynamic> _$ChatroomModelToJson(ChatroomModel instance) =>
    <String, dynamic>{
      'chatroomid': instance.chatroomid,
      'participants': instance.participants!.map((userModel) {
        return userModel.id;
      }).toList(),
      'lastmessage': instance.lastmessage,
      'createdon': instance.createdon?.toIso8601String(),
    };
