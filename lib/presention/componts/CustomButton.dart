import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget{
  CustomButton({required this.text,this.onTap});
  String text;
  VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
     return Padding(
       padding: const EdgeInsets.symmetric(horizontal: 10),
       child: ElevatedButton(child: Text(text,style:TextStyle(color:Colors.black ) ,),style:ElevatedButton.styleFrom(backgroundColor: Colors.white,shape:RoundedRectangleBorder( borderRadius: BorderRadius.circular(5.0))), onPressed: onTap, ),
     );
  }

}