import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget{
  CustomTextField({required this.hintText,required this.labelText, this.iconButton,this.onChange,this.obscureText=false});
  String labelText;
  String hintText;
  IconButton? iconButton;
  Function(String)? onChange;
  bool? obscureText;

  @override
  Widget build(BuildContext context) {
  return TextFormField(
    obscureText: obscureText!,
    validator:(value){
      if(value!.isEmpty){
        return "Field is required";
      }
    } ,
    onChanged:onChange ,
    decoration:InputDecoration(
      contentPadding:EdgeInsets.symmetric(
        horizontal: 16,
        vertical:20,
      ) ,
      labelText: labelText,
      suffixIcon:iconButton ,
      hintText: hintText,
      labelStyle:TextStyle(color:Colors.white ) ,
      hintStyle:TextStyle(color:Colors.white ) ,
      suffixIconColor:Colors.white  ,
      focusedBorder:OutlineInputBorder(
          borderSide:BorderSide(
            color:Colors.white,
          )
      ) ,
      border:OutlineInputBorder(
          borderSide:BorderSide(
            color:Colors.white,
          )
      ) ,
    ) ,
  );
  }

}