import 'dart:convert';
import 'dart:developer';
import 'package:chatappfrontend/models/chatroom_model.dart';
import 'package:chatappfrontend/models/message_model.dart';
import 'package:chatappfrontend/models/user_model.dart';
import 'package:http/http.dart';

class API {

  static String baseURL = "http://192.168.1.200:5000/api";
  static Map<String, String> headers = {
    "Content-type": "application/json"
  };

  static Future<dynamic> loginUser(String email, String password) async {
    Uri requestUri = Uri.parse(baseURL + "/user/login");
    Map<String, dynamic> dataToSend = {
      "email": email,
      "password": password
    };

    Response response = await post(requestUri, body: jsonEncode(dataToSend), headers: headers);
    dynamic decoded = jsonDecode(response.body);

    return decoded;
  }

  static Future<bool> createUser(UserModel userModel) async {
    Uri requestUri = Uri.parse(baseURL + "/user/create");

    Response response = await post(requestUri, body: jsonEncode(userModel.toJson()), headers: headers);
    dynamic decoded = jsonDecode(response.body);

    return decoded["success"] as bool;
  }

  static Future<List<UserModel>> searchUser(String email, String myEmail) async {
    Uri requestUri = Uri.parse(baseURL + "/user/search");

    Response response = await post(requestUri, body: jsonEncode({ "email": email, "myemail": myEmail }), headers: headers);
    dynamic decoded = jsonDecode(response.body);

    List<UserModel> users = [];
    for(dynamic userMap in decoded) {
      UserModel userModel = UserModel.fromJson(userMap);
      users.add(userModel);
    }

    return users;
  }

  static Future<ChatroomModel?> createRoom(ChatroomModel chatroomModel) async {

    log("API: " + chatroomModel.toJson().toString());

    Uri requestUri = Uri.parse(baseURL + "/chat/createroom");

    Response response = await post(requestUri, body: jsonEncode(chatroomModel.toJson()), headers: headers);
    dynamic decoded = jsonDecode(response.body);

    if(decoded["success"] == true) {
      ChatroomModel newChatroom = ChatroomModel.fromJson(decoded["data"]);
      return newChatroom;
    }

    return null;
  }

  static Future<List<ChatroomModel>> getChatrooms(String id) async {
    Uri requestUri = Uri.parse(baseURL + "/chat/$id");

    Response response = await get(requestUri);
    dynamic decoded = jsonDecode(response.body);

    if(decoded["success"] == true) {
      List<ChatroomModel> chatrooms = [];
      for(dynamic chatroomMap in decoded["data"]) {
        ChatroomModel chatroomModel = ChatroomModel.fromJson(chatroomMap);
        chatrooms.add(chatroomModel);
      }
      return chatrooms;
    }
    else {
      return [];
    }
    
  }

  static Future<bool> sendMessage(MessageModel messageModel) async {

    Uri requestUri = Uri.parse(baseURL + "/chat/sendmessage");

    Response response = await post(requestUri, body: jsonEncode(messageModel.toJson()), headers: headers);
    dynamic decoded = jsonDecode(response.body);

    log(decoded.toString());

    return decoded["success"];
  }

  static Future<List<MessageModel>> getMessages(ChatroomModel chatroom) async {
    Uri requestUri = Uri.parse(baseURL + "/chat/fetchmessages");

    Response response = await post(requestUri, body: jsonEncode(chatroom.toJson()), headers: headers);
    dynamic decoded = jsonDecode(response.body);

    if(decoded["success"] == true) {
      List<MessageModel> messages = [];
      for(dynamic messageMap in decoded["data"]) {
        MessageModel messageModel = MessageModel.fromJson(messageMap);
        messages.add(messageModel);
      }
      return messages;
    }
    else {
      return [];
    }
    
  }

  static Future<bool> updateRoom(ChatroomModel chatroomModel) async {
    Uri requestUri = Uri.parse(baseURL + "/chat/updateroom");

    log(chatroomModel.toJson().toString());

    Response response = await put(requestUri, body: jsonEncode(chatroomModel.toJson()), headers: headers);
    dynamic decoded = jsonDecode(response.body);

    return decoded["success"];
  }

}