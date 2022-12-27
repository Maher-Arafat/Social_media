// ignore_for_file: public_member_api_docs, sort_constructors_first

abstract class ChatRegisterStates {}

class ChatRegisterIntialState extends ChatRegisterStates {}

class ChatRegisterLoadingState extends ChatRegisterStates {}

class ChatRegisterSuccessState extends ChatRegisterStates {}

class ChatRegisterErrorState extends ChatRegisterStates {
  final String error;
  ChatRegisterErrorState(this.error);
}

class ChatCreateUserSuccessState extends ChatRegisterStates {}

class ChatCreateUserErrorState extends ChatRegisterStates {
  final String error;
  ChatCreateUserErrorState(this.error);
}

class ChatChangeRegPasswordState extends ChatRegisterStates {}
