// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageModel _$MessageModelFromJson(Map<String, dynamic> json) => MessageModel(
      messageid: json['messageid'] as String?,
      chatroomid: json['chatroomid'] as String?,
      msg: json['msg'] as String?,
      sender: json['sender'] as String?,
      createdon: json['createdon'] == null
          ? null
          : DateTime.parse(json['createdon'] as String),
    );

Map<String, dynamic> _$MessageModelToJson(MessageModel instance) =>
    <String, dynamic>{
      'messageid': instance.messageid,
      'chatroomid': instance.chatroomid,
      'msg': instance.msg,
      'sender': instance.sender,
      'createdon': instance.createdon?.toIso8601String(),
    };
