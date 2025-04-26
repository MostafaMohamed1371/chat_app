import 'package:chat_app/presention/componts/ChatBubbleFriend.dart';
import 'package:chat_app/presention/model/Message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/chat_cubit/chat_cubit.dart';
import '../componts/ChatBubble.dart';

class HomePage extends StatelessWidget {
  HomePage({this.email, this.password});
  var email;
  var password;
  static String id = "HomePage";
  final _controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    TextEditingController controller = TextEditingController();
    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) {
        List<Message> messageList =
            BlocProvider.of<ChatCubit>(context).messageList;
        if (state is ChatSuccess) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Color(0xff284461),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/scholar.png",
                    height: 70,
                  ),
                  Text(
                    "Chat",
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
              automaticallyImplyLeading: false,
              centerTitle: true,
            ),
            // ChatBubble(color:Color(0xff284461),bottomLeft:32 ,bottomRight:0 ,topLeft:32 ,topRight:32 ,horizontal:16 ,),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      reverse: true,
                      controller: _controller,
                      itemCount: messageList.length,
                      itemBuilder: (context, index) {
                        return messageList[index].id == email
                            ? ChatBubble(message: messageList[index])
                            : ChatBubbleFriend(message: messageList[index]);
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    controller: controller,
                    onSubmitted: (data) {
                      BlocProvider.of<ChatCubit>(context).SendMessage(data: data, email: email.toString());
                      controller.clear();
                      _controller.animateTo(0,
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeIn);
                    },
                    decoration: InputDecoration(
                      hintText: "send message",
                      suffixIcon: Icon(Icons.send),
                      suffixIconColor: Color(0xff284461),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          color: Color(0xff284461),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else if (state is ChatFailure) {
          return Text(state.errMessage);
        } else {
          return Text("loading");
        }
      },
    );
  }
}
