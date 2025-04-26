import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

import '../../presention/model/Message.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  CollectionReference message = FirebaseFirestore.instance.collection('messages');
  List<Message>messageList=[];
  SendMessage({required String data,required String email}){
    try{
      message.add({
        'text': data,
        'createdAt': DateTime.now(),
        'id': email
      });


    }catch(e){
      emit(ChatFailure(errMessage: e.toString()));

    }
  }
  GetMessages(){

      message.orderBy("createdAt",descending:true).snapshots().listen((event) {
        messageList.clear();
        for(var i=0;event.docs.length>i;i++){
          messageList.add(Message.fromJson(event.docs[i]));
        }
        emit(ChatSuccess());

      });



  }
}
