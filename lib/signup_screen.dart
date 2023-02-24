import 'dart:convert';

import 'package:chat_box/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'constants/endpoints.dart';

class SignupScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return SignupScreenState();
  }

}
class SignupScreenState extends State<SignupScreen>{
  TextEditingController fullNameController = TextEditingController();
  TextEditingController birthdayController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool showPassword=false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: ListView( children: [
            Padding(
              padding: const EdgeInsets.only(top: 100.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Create New Account",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600)),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 25.0, right: 25, top: 35),
              child: TextField(
                textInputAction: TextInputAction.next,
                controller: fullNameController,
                decoration: InputDecoration(
                  filled: true,
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(5)),
                  hintText: 'Enter Fullname',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 25.0, right: 25, top: 25),
              child: TextField(
                onTap: ()async{
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1950),
                      //DateTime.now() - not to allow to choose before today.
                      lastDate: DateTime(2100));

                  if (pickedDate != null) {
                    print(
                        pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                    String formattedDate =
                    DateFormat('yyyy-MM-dd').format(pickedDate);
                    print(
                        formattedDate); //formatted date output using intl package =>  2021-03-16
                    setState(() {
                      birthdayController.text =
                          formattedDate; //set output date to TextField value.
                    });
                  }
                },
                readOnly: true,
                controller: birthdayController,
                decoration: InputDecoration(
                  filled: true,
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(5)),
                  hintText: 'Enter Birthday',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 25.0, right: 25, top: 25),
              child: TextField(
                keyboardType: TextInputType.phone,
                controller: mobileNoController,
                decoration: InputDecoration(
                  filled: true,
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(5)),
                  hintText: 'Enter Mobile No.',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 25.0, right: 25, top: 25),
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                  filled: true,
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(5)),
                  hintText: 'Enter Email',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 25.0, right: 25, top: 25),
              child: TextField(
                controller: userNameController,
                decoration: InputDecoration(
                  filled: true,
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(5)),
                  hintText: 'Enter Username',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 25.0, right: 25, top: 25,bottom: 25),
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
              margin: EdgeInsets.only(bottom: 25,left: 80,right: 80),
              child: ElevatedButton(
                  onPressed: () {
                    signup();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5.0,
                      vertical: 10,
                    ),
                    child: Text("Sign Up"),
                  )),
            ),
          ]),
        ));
  }


void signup() async{
  String fullName=fullNameController.text;
  String birthday=birthdayController.text;
  String mobileNo=mobileNoController.text;
  String email=emailController.text;
  String userName=userNameController.text;
  String password=passwordController.text;
  var request={};
  request['fullName']=fullName;
  request['birthday']=birthday;
  request['phoneNo']=mobileNo;
  request['email']=email;
  request['userName']=userName;
  request['password']=password;
  var response=await http.post(Uri.parse(Endpoints.signUpUrl),body:jsonEncode(request ),headers: {'Content-Type':'application/json'});
  print(response.body);
  var decodedResponse=jsonDecode(response.body);
  if(decodedResponse['errorCode']==0 && decodedResponse['status']==true)
  {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('SignUp Successful')));
    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
  }
}}