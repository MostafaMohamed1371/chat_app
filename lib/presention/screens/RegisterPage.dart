import 'package:chat_app/presention/screens/HomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../cubit/register_cubit/register_cubit.dart';
import '../../helpers/ShowSnackBar.dart';
import '../componts/CustomButton.dart';
import '../componts/CustomTextField.dart';

class RegisterPage extends StatefulWidget{

   static String id = "RegisterPage";

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
   String? email;

   String? password;

   GlobalKey<FormState> formKey=GlobalKey();

   bool isLoading=false;
   bool obscureText=true;


   @override
  Widget build(BuildContext context) {
     return BlocConsumer<RegisterCubit, RegisterState>(
  listener: (context, state) {
    if(state is RegisterLoading){
      isLoading=true;
    }else if (state is RegisterSuccess){
      showSnackBar(context,'Success');
      isLoading=false;

    } else if(state is RegisterFailure){
      showSnackBar(context,state.errMessage);
      isLoading=false;
    }else{
      isLoading=false;

    }
   },
  builder:(context, state) => ModalProgressHUD(
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
                 child: Text("Register",style:TextStyle(color:Colors.white,fontSize: 18,fontWeight:FontWeight.bold,),),
               ),
               Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 12),
                 child: CustomTextField(hintText: 'Enter your email', labelText: 'Email',onChange:(value){email=value;} ,),
               ),
               SizedBox(height: 20,),
               Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 12),
                 child: CustomTextField(hintText: 'Enter your password', labelText: 'Password',iconButton:IconButton(onPressed:(){
                   setState(() {
                     obscureText=!obscureText;
                   });
                 } , icon:obscureText==true? Icon(Icons.visibility_off): Icon(Icons.visibility)) ,onChange:(value){password=value;},obscureText:obscureText ,),
               ),
               SizedBox(height: 50,),
               CustomButton(text: 'Register',onTap:() async{
                 if (formKey.currentState!.validate()) {
                   BlocProvider.of<RegisterCubit>(context).registerUser(email!, password!);
                   // setState(() {
                   //   isLoading=true;
                   // });
                   // try {
                   //   UserCredential user = await registerUser();
                   //
                   //   showSnackBar(context,'Success');
                   //
                   // } on FirebaseAuthException catch (e) {
                   //   if (e.code == 'weak-password') {
                   //     showSnackBar(context,'weak-password');
                   //   } else if (e.code == 'email-already-in-use') {
                   //     showSnackBar(context,'email-already-in-use');
                   //   }
                   // } catch (e) {
                   //   showSnackBar(context,'Found wrong');
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
                   Text("already have an account?",style:TextStyle(color:Colors.white,fontSize: 12),),
                   TextButton(onPressed:(){Navigator.pop(context); }, child:Text("Login",style:TextStyle(color:Colors.white ) ,), )

                 ],
               )

             ],
           ),
         ) ,
       ),
     ),
);
  }



  // Future<UserCredential> registerUser() async {
  //    final user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
  //     email: email!,
  //     password: password!,
  //   );
  //   return user;
  // }
}