import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginEvent>((event, emit) async {
       if(event is OnLoginEvent){
          emit(LoginLoading());
         try {
           await FirebaseAuth.instance.signInWithEmailAndPassword(
               email: event.email!,
               password: event.password!
           );
           emit(LoginSuccess());

         }
         on FirebaseAuthException catch (e) {
           print("FirebaseAuthException${e.code}");
             if (e.code =='invalid-credential') {
               emit(LoginFailure(errMessage: 'No user found for that email.'));
             }
            else if (e.code =='invalid-email') {
             emit(LoginFailure(errMessage: 'Bad text email'));
           }
             else if (e.code =='too-many-requests') {
               emit(LoginFailure(errMessage: 'Too many enter,you don,t user'));
             }
         }
         //   if (e.code =='invalid-credential') {
         //     emit(LoginFailure(errMessage: 'No user found for that email.'));
         //
         //   } else if (e.code =='wrong-password') {
         //     emit(LoginFailure(errMessage: 'Wrong password provided for that user.'));
         //
         //   }else  if (e.code == 'weak-password') {
         //     emit(LoginFailure(errMessage: 'weak-password'));
         //   } else if (e.code == 'email-already-in-use') {
         //     emit(LoginFailure(errMessage: 'email-already-in-use'));
         //   }
       //  }
       catch(e){
           print("Found error ${e.toString()}");
           emit(LoginFailure(errMessage:e.toString()));

         }
       }
    });
  }
  @override
  void onTransition(Transition<LoginEvent, LoginState> transition) {
    super.onTransition(transition);
    print(transition);
  }
}
