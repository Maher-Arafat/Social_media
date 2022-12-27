// ignore_for_file: avoid_print

import 'package:chat_app/modules/login/cubit/states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatLoginCubit extends Cubit<ChatLoginStates> {
  ChatLoginCubit() : super(ChatLoginIntialState());

  static ChatLoginCubit get(context) => BlocProvider.of(context);

  //ChatLoginModel? loginModel;

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ChatChangePasswordState());
  }

  void userLogin({required String email, required String password}) {
    emit(ChatLoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      print(value.user?.email);
      print(value.user?.uid);
      emit(ChatLoginSuccessState(value.user!.uid));
    }).catchError((error) {
      emit(ChatLoginErrorState(error.toString()));
    });
  }
}
