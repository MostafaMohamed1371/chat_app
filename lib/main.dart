import 'package:chat_app/presention/screens/HomePage.dart';
import 'package:chat_app/presention/screens/LoginPage.dart';
import 'package:chat_app/presention/screens/RegisterPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/login_bloc/login_bloc.dart';
import 'cubit/chat_cubit/chat_cubit.dart';
import 'cubit/register_cubit/register_cubit.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ChatApp());
}

class ChatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginBloc()),
        BlocProvider(create: (context) => RegisterCubit()),

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          LoginPage.id: (context) => LoginPage(),
          RegisterPage.id: (context) => RegisterPage(),
          HomePage.id: (context) =>
              BlocProvider(
                create: (context) => ChatCubit()..GetMessages(),
                child: HomePage(),
              )
        },
        initialRoute: "LoginPage",
      ),
    );
  }

}
