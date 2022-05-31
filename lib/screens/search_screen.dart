import 'package:chatappfrontend/models/user_model.dart';
import 'package:chatappfrontend/screens/chat_screen.dart';
import 'package:chatappfrontend/services/api.dart';
import 'package:chatappfrontend/widgets/my_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  final UserModel myUser;
  const SearchScreen({ Key? key, required this.myUser }) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  bool isLoading = false;
  List<UserModel> users = [];
  TextEditingController searchController = TextEditingController();

  void searchUser() async {
    setState(() {
      isLoading = true;
    });
    String email = searchController.text.trim();
    users = await API.searchUser(email);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search"),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 15
          ),
          child: Column(
            children: [

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Flexible(
                    child: MyTextField(
                      controller: searchController,
                      hintText: "Search",
                    ),
                  ),

                  IconButton(
                    onPressed: () {
                      searchUser();
                    },
                    icon: Icon(Icons.search),
                  ),

                ],
              ),

              SizedBox(height: 15,),

              Expanded(
                child: mainListView(),
              ),

            ],
          ),
        ),
      ),
    );
  }

  Widget mainListView() {
    if(isLoading == true) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    else {
      if(users.length > 0) {
        return ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {

            return ListTile(
              leading: CircleAvatar(
                child: Text(users[index].fullname.toString()[0]),
              ),
              title: Text(users[index].fullname.toString()),
              subtitle: Text(users[index].email.toString()),
              trailing: CupertinoButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(context, CupertinoPageRoute(
                    builder: (context) => ChatScreen(
                      targetUser: users[index],
                      myUser: widget.myUser,
                    )
                  ));
                },
                padding: EdgeInsets.all(0),
                child: Icon(Icons.message),
              ),
            );

          },
        );
      }
      else {
        return Center(
          child: Text("No users found!"),
        );
      }
    }
  }
}