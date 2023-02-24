import 'package:chat_box/ChatBoxWindowScreen.dart';
import 'package:chat_box/login_screen.dart';
import 'package:chat_box/message_screen.dart';
import 'package:chat_box/search_screen.dart';
import 'package:chat_box/signup_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,

      ),
      home: LoginScreen()
    );
  }
}

