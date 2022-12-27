// ignore_for_file: public_member_api_docs, sort_constructors_first

abstract class ChatLoginStates {}

class ChatLoginIntialState extends ChatLoginStates {}

class ChatLoginLoadingState extends ChatLoginStates {}

class ChatLoginSuccessState extends ChatLoginStates {
  final String uId;
  ChatLoginSuccessState(this.uId);
}

class ChatLoginErrorState extends ChatLoginStates {
  final String error;
  ChatLoginErrorState(this.error);
}

class ChatChangePasswordState extends ChatLoginStates {}
