import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StatusScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return StatusScreenState();
  }
}
class StatusScreenState extends State<StatusScreen>
{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(floatingActionButton: FloatingActionButton(backgroundColor: Colors.indigoAccent,child: Icon(CupertinoIcons.camera_fill),
      onPressed: () {  },),);
  }

}