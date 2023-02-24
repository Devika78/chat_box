import 'package:chat_box/message_screen.dart';
import 'package:chat_box/modal/chat_modal.dart';
import 'package:chat_box/search_screen.dart';
import 'package:chat_box/action_button_screen.dart';
import 'package:chat_box/service/webservice.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ChatScreenState();
  }
}

class ChatScreenState extends State<ChatScreen> {
  List<ChatModal> chatList = [];
  SharedPreferences? sharedPreferences;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getChats();
    initializeSharedPrefernces();
  }
  void initializeSharedPrefernces()
  async{
    sharedPreferences=await SharedPreferences.getInstance();
  }
  void getChats() async {
    var resp = await Webservice.fetchChats();
    print(resp);
    if (resp['errorCode'] == 0 && resp['status'] == true) {
      List<ChatModal> tempList = [];
      (resp['chat'] as List).forEach((element) {
        tempList.add(ChatModal.fromJson(element));
      });
      setState(() {
        chatList = tempList;
      });
    }
  }

  String getSecondUserName(ChatModal chatModal)
  {
    if(sharedPreferences==null)
      {
        return "";
      }
    int userId=sharedPreferences!.getInt("userId")!;
    if(chatModal.sender.id==userId)
      {
        return chatModal.receiver.fullName;
      }
    else{
      return chatModal.sender.fullName;
    }
    return chatModal.sender.id==userId?chatModal.receiver.fullName:chatModal.sender.fullName;
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: chatList.isEmpty?

     GestureDetector(
       onTap: () {
         Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen(),));
       },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.person_add,size: 100,),
            Center(child: Text("Start a new Conversation",style: TextStyle(fontSize: 25),textAlign: TextAlign.center)),
          ],
        ),
      ):ListView.builder(itemBuilder: (context, index) {
        ChatModal chatModal=chatList[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => MessageScreen(),));
          },
          child: Padding(
            padding: const EdgeInsets.only(top:15.0,left: 10,right: 10),
            child: Container(child:Column(
              children: [
                Row(children: [
                  Expanded(flex: 30,child: Icon(Icons.account_circle,color: Colors.grey,size: 60)),
                  Expanded(flex:110,child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(getSecondUserName(chatModal),style: TextStyle(fontWeight: FontWeight.w600),),
                  )),

                ]),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 5),
                  child: Divider(height: 0.5,),
                )
              ],
            ),),
          ),
        );
      },
          itemCount: chatList.length),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigoAccent,
        child: Icon(CupertinoIcons.chat_bubble_2_fill),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => ExampleExpandableFab(),));
        },
      ),
    );
  }
}
