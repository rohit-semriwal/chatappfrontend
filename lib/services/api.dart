import 'dart:convert';
import 'package:chatappfrontend/models/chatroom_model.dart';
import 'package:chatappfrontend/models/user_model.dart';
import 'package:http/http.dart';

class API {

  static String baseURL = "http://192.168.1.202:5000/api";
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

  static Future<List<UserModel>> searchUser(String email) async {
    Uri requestUri = Uri.parse(baseURL + "/user/search");

    Response response = await post(requestUri, body: jsonEncode({ "email": email }), headers: headers);
    dynamic decoded = jsonDecode(response.body);

    List<UserModel> users = [];
    for(dynamic userMap in decoded) {
      UserModel userModel = UserModel.fromJson(userMap);
      users.add(userModel);
    }

    return users;
  }

  static Future<ChatroomModel?> createRoom(ChatroomModel chatroomModel) async {
    Uri requestUri = Uri.parse(baseURL + "/chat/createroom");

    Response response = await post(requestUri, body: jsonEncode(chatroomModel.toJson()), headers: headers);
    dynamic decoded = jsonDecode(response.body);

    if(decoded["success"] == true) {
      ChatroomModel newChatroom = ChatroomModel.fromJson(decoded["data"]);
      return newChatroom;
    }

    return null;
  }

}