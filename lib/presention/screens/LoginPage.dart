import 'package:chat_app/presention/screens/HomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../bloc/login_bloc/login_bloc.dart';
import '../../helpers/ShowSnackBar.dart';
import '../componts/CustomButton.dart';
import '../componts/CustomTextField.dart';
import 'RegisterPage.dart';


class LoginPage extends StatefulWidget {
  static String id = "LoginPage";

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? email;
  String? password;

  GlobalKey<FormState> formKey=GlobalKey();

  bool isLoading=false;

  bool obscureText=true;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
  listener: (context, state) {
    if(state is LoginSuccess){
      showSnackBar(context,'Success login');
      Navigator.pushNamed(context, HomePage.id,arguments:email );
      isLoading=false;
    }
     else if(state is LoginFailure){
       showSnackBar(context,state.errMessage);
       isLoading=false;
    }else{
      isLoading=true;
    }
  },
    builder:(context, state)=>ModalProgressHUD(
      inAsyncCall:isLoading ,
      child: Scaffold(
        backgroundColor:Color(0xff284461) ,
        body:Form(
          key:formKey ,
          child: ListView(
            children: [
              SizedBox(height: 100,),
              Image(image: AssetImage("assets/images/scholar.png"),height: 100,),
              Padding(
                padding: const EdgeInsets.only(left: 150),
                child: Text("Scolar Chat",style:TextStyle(color:Colors.white,fontSize: 18,fontWeight:FontWeight.bold,fontFamily: "Pacifico") ,),
              ),
              SizedBox(height: 80,),
              Padding(
                padding: const EdgeInsets.only(left:10,bottom: 20),
                child: Text("Login",style:TextStyle(color:Colors.white,fontSize: 18,fontWeight:FontWeight.bold,),),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: CustomTextField(hintText: 'Enter your email', labelText: 'Email',onChange:(value){email=value;}),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: CustomTextField(hintText: 'Enter your password', labelText: 'Password',iconButton:IconButton(onPressed:(){
                  setState(() {
                    obscureText=!obscureText;
                  });
                } , icon: obscureText==true? Icon(Icons.visibility_off): Icon(Icons.visibility)),onChange:(value){password=value;},obscureText:obscureText , ),
              ),
              SizedBox(height: 50,),
              CustomButton(text: 'Login',onTap:() async{
                if (formKey.currentState!.validate()) {
                  BlocProvider.of<LoginBloc>(context).add(OnLoginEvent(email: email!, password: password!));
                  // setState(() {
                  //   isLoading=true;
                  // });
                  // try {
                  //   UserCredential user = await loginUser();
                  //   if(email==user.user!.email){
                  //     Navigator.pushNamed(context, HomePage.id,arguments:email );
                  //   }
                  // } on FirebaseAuthException catch (e) {
                  //   if (e.code == 'user-not-found') {
                  //     showSnackBar(context,'No user found for that email.');
                  //   } else if (e.code == 'wrong-password') {
                  //     showSnackBar(context,'Wrong password provided for that user.');
                  //   }
                  // }catch(e){
                  //   showSnackBar(context,'Found Wrong');
                  //
                  // }
                  // setState(() {
                  //   isLoading=false;
                  // });
                }
              } ,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("don't have an account?",style:TextStyle(color:Colors.white,fontSize: 12),),
                  TextButton(onPressed:(){Navigator.pushNamed(context, RegisterPage.id); }, child:Text("Register",style:TextStyle(color:Colors.white ) ,), )

                ],
              )

            ],
          ),
        ) ,
      ),
    ));

  }
}