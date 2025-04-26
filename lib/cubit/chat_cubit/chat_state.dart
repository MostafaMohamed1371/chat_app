part of 'chat_cubit.dart';

@immutable
abstract class ChatState {}

class ChatInitial extends ChatState {}
class ChatSuccess extends ChatState {}
class ChatFailure extends ChatState {
  String errMessage;
  ChatFailure({required this.errMessage});
}

