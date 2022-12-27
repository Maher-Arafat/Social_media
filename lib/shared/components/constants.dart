import 'package:chat_app/modules/login/login_screen.dart';
import 'package:chat_app/network/local/cach_helper.dart';
import 'package:chat_app/shared/cubit/appcubit/cubit.dart';
import 'package:flutter/cupertino.dart';

void signOut(BuildContext context) {
  CacheHelper.removeData(key: 'uId').then((value) {
    if (value == true) {
      AppCubit.get(context).navigateFinish(context, ChatLoginScreen());
    }
  });
}

String? token = '';

String? uId = '';


//fNN3VXugYSVDxuFwZ4AGjPKLPgD3
