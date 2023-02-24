import 'dart:convert';

import 'package:chat_box/ChatBoxWindowScreen.dart';
import 'package:chat_box/constants/endpoints.dart';
import 'package:chat_box/signup_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
   SharedPreferences? sharedPreferences;
  bool showPassword=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeSharedPrefernces();
  }
  void initializeSharedPrefernces()
  async{
    sharedPreferences =await SharedPreferences.getInstance();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center, children: [
              Padding(
                padding: const EdgeInsets.only(top: 100.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("ChatBox",
                        style: TextStyle(
                            fontFamily: GoogleFonts.caveat().fontFamily,
                            fontSize: 52,
                            fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 25.0, right: 25, top: 35),
                child: TextField(
                  controller: userNameController,
                  decoration: InputDecoration(
                    filled: true,
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(5)),
                    hintText: 'Enter username',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 25.0, right: 25, top: 25, bottom: 25),
                child: TextField(
                  obscureText: !showPassword,

                  controller: passwordController,
                  decoration: InputDecoration(

                    suffixIcon: showPassword?IconButton(
                      icon: Icon(CupertinoIcons.eye_slash_fill),onPressed: () {
                      setState(() {
                        showPassword=false;
                      });
                    },):IconButton(icon: Icon(Icons.remove_red_eye),onPressed: () {
                      setState(() {
                        showPassword=true;
                      });
                    },),
                    filled: true,
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(5)),
                    hintText: 'Enter Password',
                  ),
                ),
              ),
              Container(
                height: 40,
                margin: EdgeInsets.only(bottom: 25),
                child: ElevatedButton(
                    onPressed: () {
                      login();
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15.0,
                        vertical: 10,
                      ),
                      child: Text("Log In"),
                    )),
              ),
              Text(
                "Forget Password",
                style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
              ),
              Spacer(),
              Text("New to ChatBox!"),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SignupScreen(),));
                },
                child: Text(
                  "Create new account",
                  style: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.w600, fontSize: 15),
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ]),
          ),
        ],
      ),
    ));
  }

  void login() async{
    String userName=userNameController.text;
    String password=passwordController.text;
    var request={};
    request['userName']=userName;
    request['password']=password;
    var response=await http.post(Uri.parse(Endpoints.loginUrl),body:jsonEncode(request ),headers: {'Content-Type':'application/json'});
    print(response.body);
    var decodedResponse=jsonDecode(response.body);
    if(decodedResponse['errorCode']==0 && decodedResponse['status']==true)
      {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login Successful')));
    sharedPreferences?.setInt("userId", decodedResponse['user']['id']);

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ChatBoxWindowScreen(),));
      }
    else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Wrong Credentials')));
    }
  }
}
