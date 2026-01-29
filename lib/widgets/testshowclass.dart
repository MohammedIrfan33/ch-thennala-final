import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class tesstshowclass extends StatelessWidget{

  String status;
  String respone;
  tesstshowclass({required this.status, required this.respone});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child:
        Column(
          mainAxisAlignment:  MainAxisAlignment.center,
          children: [
            Text("status:$status"),

          Text("reaponse:$respone")



          ],
        )


        ,
      ),




    );
  }










}