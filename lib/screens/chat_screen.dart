import 'dart:convert';
import 'dart:developer';

import 'package:chatappfrontend/models/chatroom_model.dart';
import 'package:chatappfrontend/models/message_model.dart';
import 'package:chatappfrontend/models/user_model.dart';
import 'package:chatappfrontend/services/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:uuid/uuid.dart';
import 'package:socket_io_client/socket_io_client.dart';

class ChatScreen extends StatefulWidget {
  final UserModel myUser;
  final UserModel targetUser;
  const ChatScreen({ Key? key, required this.myUser, required this.targetUser }) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  Socket? socket;

  List<MessageModel> messages = [];
  TextEditingController msgController = TextEditingController();

  bool isLoading = true;
  ChatroomModel? chatroomModel;

  void initializeChatroom() async {
    ChatroomModel newChatroom = ChatroomModel(
      chatroomid: Uuid().v1(),
      participants: [ widget.myUser, widget.targetUser ]
    );

    log("We wrote: " + newChatroom.toJson().toString());

    ChatroomModel? savedChatroom = await API.createRoom(newChatroom);
    if(savedChatroom != null) {
      chatroomModel = savedChatroom;

      // Send event to socket
      socket!.emit("join-room", savedChatroom.chatroomid);
    }
    else {
      // SHOW ERROR
      log("Can't load chatroom");
    }
  }

  void sendMessage() async {
    String message = msgController.text.trim();
    msgController.clear();

    if(message != "" && chatroomModel != null) {
      MessageModel messageModel = MessageModel(
        chatroomid: chatroomModel!.chatroomid.toString(),
        messageid: Uuid().v1(),
        msg: message,
        sender: widget.myUser.userid,
        createdon: DateTime.now()
      );

      setState(() {
        messages.add(messageModel);
      });

      socket!.emit("new-message", jsonEncode(messageModel.toJson()));
    }
  }

  void initializeSocketConnection() async {
    log(widget.myUser.toJson().toString());

    socket = io("http://192.168.1.202:5000", OptionBuilder().setTransports(['websocket']).build());

    socket!.onConnect((socket) {
      log("Connected to the server!");
    });
    socket!.onError((data) {
      log("Can't connect to the socket!");
    });
    socket!.onDisconnect((data) {
      log("Disconnected from the server!");
    });

    socket!.on("new-message", (data) {
      log("New message received");
      dynamic decodedData = jsonDecode(data);
      MessageModel messageModel = MessageModel.fromJson(decodedData);
      setState(() {
        messages.add(messageModel);
      });
    });

    socket!.connect();
  }

  @override
  void initState() {
    super.initState();
    initializeSocketConnection();
    initializeChatroom();
  }

  @override
  void dispose() {
    socket?.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [

            CircleAvatar(
              child: Text(widget.targetUser.fullname![0]),
            ),
            SizedBox(width: 10,),
            Text(widget.targetUser.fullname.toString()),

          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [

            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10
                ),
                child: ListView.builder(
                  physics: BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()
                  ),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {

                    return Row(
                      mainAxisAlignment: (messages[index].sender == widget.myUser.userid) ? MainAxisAlignment.end : MainAxisAlignment.start,
                      children: [
                        Container(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width / 1.5
                          ),
                          decoration: BoxDecoration(
                            color: (messages[index].sender == widget.myUser.userid) ? Colors.blue : Colors.grey,
                            borderRadius: BorderRadius.circular(7)
                          ),
                          margin: EdgeInsets.symmetric(
                            vertical: 2
                          ),
                          padding: EdgeInsets.all(10),
                          child: Text(messages[index].msg.toString(), style: TextStyle(
                            color: Colors.white
                          ),)
                        ),
                      ],
                    );

                  },
                ),
              ),
            ),

            Container(
              color: Colors.grey[300],
              padding: EdgeInsets.symmetric(
                vertical: 5,
                horizontal: 15,
              ),
              child: Row(
                children: [

                  Flexible(
                    child: TextField(
                      controller: msgController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Message.."
                      ),
                    )
                  ),

                  CupertinoButton(
                    onPressed: () {
                      sendMessage();
                    },
                    padding: EdgeInsets.zero,
                    child: Icon(Icons.send),
                  ),

                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}