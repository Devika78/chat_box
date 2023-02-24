import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CallsScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CallsScreenState();
  }

}
class CallsScreenState extends State<CallsScreen>
{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(floatingActionButton: FloatingActionButton(backgroundColor: Colors.indigoAccent,child: Icon(CupertinoIcons.phone_badge_plus),
      onPressed: () {  },),);
  }

}
