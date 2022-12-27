// ignore_for_file: avoid_print

import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/modules/register/cubit/states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatRegisterCubit extends Cubit<ChatRegisterStates> {
  ChatRegisterCubit() : super(ChatRegisterIntialState());

  static ChatRegisterCubit get(context) => BlocProvider.of(context);

  //ChatLoginModel? loginModel;

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ChatChangeRegPasswordState());
  }

  void userRegister({
    required String email,
    required String name,
    required String phone,
    required String password,
  }) {
    emit(ChatRegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
    print(value.user!.email);
      print(value.user!.uid);
      userCreate(
        email: email,
        name: name,
        phone: phone,
        uId: value.user!.uid,
      );
    }).catchError((error) {
      print(error);
      emit(ChatRegisterErrorState(error.toString()));
    });
  }

  void userCreate({
    required String email,
    required String name,
    required String phone,
    required String uId,
  }) {
    UserModel model = UserModel(
      name: name,
      email: email,
      phone: phone,
      uId: uId,
      isEmailVrefied: false,
      bio: 'Write your bio...',
      image:
          'https://img.freepik.com/free-vector/man-shows-gesture-great-idea_10045-637.jpg?size=338&ext=jpg&ga=GA1.2.680799210.1670709065&semt=sph',
      cover:
          'https://img.freepik.com/free-photo/bearded-man-denim-shirt-round-glasses_273609-11770.jpg?size=626&ext=jpg&ga=GA1.2.680799210.1670709065&semt=sph',
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      emit(ChatCreateUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ChatCreateUserErrorState(error.toString()));
    });
  }
}
