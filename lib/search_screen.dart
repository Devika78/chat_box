import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chat_box/service/webservice.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'message_screen.dart';
import 'modal/user_modal.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SearchScreenState();
  }
}

class SearchScreenState extends State<SearchScreen>{
  List<UserModal>userList=[];
  SharedPreferences? sharedPreferences;
  TextEditingController searchController=TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getUser();
    initializeSharedPrefernces();
  }
  void initializeSharedPrefernces()
  async{
    sharedPreferences=await SharedPreferences.getInstance();
  }
  void getUser() async {
    var resp = await Webservice.fetchUsers(searchController.text);
    print(resp);
    if (resp['errorCode'] == 0 && resp['status'] == true) {
      List<UserModal> tempList = [];
      (resp['users'] as List).forEach((element) {
        tempList.add(UserModal.fromJson(element));
      });
      setState(() {
        userList = tempList;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.indigoAccent,
          // The search area here
          title: Container(
            width: double.infinity,
            height: 40,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5)),
            child: Center(
              child: TextField(controller: searchController,
                onChanged: (value) {
                if(searchController.text.length>=3)
                  getUser();
                },
                decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        /* Clear the search field */
                      },
                    ),
                    hintText: 'Search...',
                    border: InputBorder.none),
              ),
            ),
          )),

       body: ListView.builder(itemBuilder: (context, i) {
          UserModal userModal=userList[i];
          return GestureDetector(
            onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MessageScreen(),));
            },
            child: Padding(
              padding: const EdgeInsets.only(top:15.0,left: 10,right: 10),
              child: Container(child:Column(
                children: [
                  Row(children: [
                    Expanded(flex: 30,child: Icon(Icons.account_circle,color: Colors.grey,size: 60)),
                    Expanded(flex:110,child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(userModal.userName),
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
            itemCount: userList.length),
    );
  }
}