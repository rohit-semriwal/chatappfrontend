import 'dart:developer';

import 'package:chatappfrontend/models/chatroom_model.dart';
import 'package:chatappfrontend/models/user_model.dart';
import 'package:chatappfrontend/services/api.dart';
import 'package:flutter/cupertino.dart';

class ChatProvider with ChangeNotifier {

  bool isLoading = true;
  List<ChatroomModel> chatrooms = [];

  void initialize(UserModel userModel) async {
    chatrooms = await API.getChatrooms(userModel.id.toString());
    isLoading = false;
    notifyListeners();
  }

}