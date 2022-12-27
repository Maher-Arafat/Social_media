// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chat_app/shared/cubit/appcubit/states.dart';

import '../../../network/local/cach_helper.dart';

class AppCubit extends Cubit<AppStates>{
  AppCubit():super(AppIntialState());
  static AppCubit get(context)=>BlocProvider.of(context);


  bool isDark = false;
  void changeModeState({bool? darkfromShared}) {
    if (darkfromShared != null) {
      isDark = darkfromShared;
      print(isDark.toString());
      emit(AppChangeModeState());
    } else {
      isDark = !isDark;
      print(isDark.toString());
      CacheHelper.putBool(key: 'isDark', value: isDark).then(
            (value) => emit(AppChangeModeState()),
      );
    }
  }

  
void navigateTo(context, widget) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => widget,
        ),
      );

  
void navigateFinish(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (route) => false);



}