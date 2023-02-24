import 'package:chat_box/search_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chat_box/calls_screen.dart';
import 'package:chat_box/camera_screen.dart';
import 'package:chat_box/chats_screen.dart';
import 'package:chat_box/status_screen.dart';


class ChatBoxWindowScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ChatBoxWindowScreenState();
  }
  }

class ChatBoxWindowScreenState extends State<ChatBoxWindowScreen> with SingleTickerProviderStateMixin {
  late TabController tabController=TabController(vsync: this,length: 4);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  tabController.index=1;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar( backgroundColor: Colors.indigoAccent,
        title: new Text("ChatBox", style: TextStyle(color: Colors.white, fontSize: 22.0, fontWeight: FontWeight.w600),),
        actions: <Widget>[
          IconButton(
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) =>  SearchScreen())),
              icon: const Icon(Icons.search)),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Icon(Icons.more_vert),
          ),
          // Navigate to the Search Screen
        ],


        bottom: TabBar(
          controller: tabController,
          tabs: [
            Tab(child: Icon(Icons.camera_alt),),
            Tab(child: Text("CHATS"),),
            Tab(child: Text("STATUS",)),
            Tab(child: Text("CALLS",)),
          ], indicatorColor: Colors.white,
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          CameraScreen(),
          ChatScreen(),
          StatusScreen(),
          CallsScreen(),
        ],
      ),
    );
  }
}