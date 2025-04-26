part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class OnLoginEvent extends LoginEvent{
  String email;

  String password;
  OnLoginEvent({required this.email,required this.password});
}
