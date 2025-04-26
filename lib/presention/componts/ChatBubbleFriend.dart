import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/Message.dart';

class ChatBubbleFriend extends StatelessWidget{
  ChatBubbleFriend({required this.message});

  Message message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment:Alignment.centerRight ,
      child: Container(
          padding:EdgeInsets.symmetric(horizontal:16 ,vertical:16 ) ,
          margin:EdgeInsets.all(16) ,
          decoration:BoxDecoration(
              borderRadius:BorderRadius.only(
                topLeft:Radius.circular(32) ,
                topRight: Radius.circular(32),
                bottomLeft: Radius.circular(32),
              ) ,
              color:Color(0xff006186)
          ) ,
          child: Text(message.message,style:TextStyle(color:Colors.white ) ,)
      ),
    );

  }

}