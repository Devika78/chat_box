import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CameraScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CamerScreenState();
  }

}
class CamerScreenState extends State<CameraScreen>
{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(floatingActionButton: FloatingActionButton(backgroundColor: Colors.indigoAccent,child: Icon(CupertinoIcons.camera_fill),
      onPressed: () {  },),);
  }

}