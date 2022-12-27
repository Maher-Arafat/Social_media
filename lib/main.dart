// ignore_for_file: avoid_print, unnecessary_null_comparison, must_be_immutable

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chat_app/layout/social_app/chat_layout.dart';
import 'package:chat_app/layout/social_app/cubit/cubit.dart';
import 'package:chat_app/modules/login/login_screen.dart';
import 'package:chat_app/shared/bloc_observer.dart';
import 'package:chat_app/shared/components/components.dart';
import 'package:chat_app/shared/components/constants.dart';
import 'package:chat_app/shared/cubit/appcubit/cubit.dart';
import 'package:chat_app/shared/cubit/appcubit/states.dart';
import 'package:chat_app/shared/styles/themes.dart';

import 'network/local/cach_helper.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
   print('on background message');
    print(message.data.toString());
    ShowToast(text: 'on background message', state: ToastStates.SUCCESS);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  //foreground fcm
  var token = await FirebaseMessaging.instance.getToken();
  print(token);
  FirebaseMessaging.onMessage.listen((event) {
    print('on message');
    print(event.data.toString());
    ShowToast(text: 'on message', state: ToastStates.SUCCESS);
  });
  //when click on notification to open app
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print('on message opened app');
    print(event.data.toString());
    ShowToast(text: 'on message opened app', state: ToastStates.SUCCESS);
  });
  //background fcm
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  Bloc.observer = MyBlocObserver();

  await CacheHelper.init();

  bool? isDark = CacheHelper.getBool(key: 'isDark');

  Widget widget;
  uId = CacheHelper.getData(key: 'uId');
  if (uId != null) {
    widget = const ChatLayOut();
  } else {
    widget = ChatLoginScreen();
  }

  runApp(MyApp(
    isDark: isDark,
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
   bool? isDark;
   Widget? startWidget;

   MyApp({super.key, required this.isDark, required this.startWidget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              AppCubit()//..changeModeState(darkfromShared: isDark!),
        ),
        BlocProvider(
          create: (context) => ChatCubit()
            ..getUserData()
            ..getPosts(),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode:
                AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home: Directionality(
              textDirection: TextDirection.ltr,
              child: startWidget!,
            ),
          );
        },
      ),
    );
  }
}
