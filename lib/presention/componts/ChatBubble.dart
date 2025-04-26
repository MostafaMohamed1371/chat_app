import 'package:chat_app/presention/model/Message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget{
  ChatBubble({required this.message});

 Message message;

  @override
  Widget build(BuildContext context) {
   return Align(
     alignment:Alignment.centerLeft ,
     child: Container(
       padding:EdgeInsets.symmetric(horizontal:16 ,vertical:16 ) ,
       margin:EdgeInsets.all(16) ,
       decoration:BoxDecoration(
         borderRadius:BorderRadius.only(
           topLeft:Radius.circular(32) ,
           topRight: Radius.circular(32),
           bottomRight: Radius.circular(32),
         ) ,
         color:Color(0xff284461)
       ) ,
         child: Text(message.message,style:TextStyle(color:Colors.white ) ,)
     ),
   );

  }

}