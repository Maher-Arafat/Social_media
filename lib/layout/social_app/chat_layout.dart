import 'package:chat_app/modules/new_post/new_post_screen.dart';
import 'package:chat_app/shared/cubit/appcubit/cubit.dart';
import 'package:chat_app/shared/styles/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chat_app/layout/social_app/cubit/cubit.dart';
import 'package:chat_app/layout/social_app/cubit/states.dart';

class ChatLayOut extends StatelessWidget {
  const ChatLayOut({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatCubit, ChatStates>(
      listener: (context, state) {
        if (state is ChatNewPostState) {
          AppCubit.get(context).navigateTo(context, NewPostScreen());
        }
      },
      builder: (context, state) {
        var cubit = ChatCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.titls[cubit.crntIdx]),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(IconBroken.Search),
              ),
              const SizedBox(width: 4),
            ],
          ),
          body: cubit.screns[cubit.crntIdx],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.crntIdx,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Chat), label: 'Chats'),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Paper_Upload), label: 'Post'),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Notification), label: 'Notification'),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Setting), label: 'Settings'),
            ],
            onTap: (idx) {
              cubit.changBottomNav(idx);
            },
          ),
        );
      },
    );
  }
}

/*

                    Container(
                      color: Colors.amber.withOpacity(.5),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            const Icon(Icons.info_outlined),
                            const SizedBox(width: 15),
                            const Expanded(
                              child: Text('Please verify your Email'),
                            ),
                            const SizedBox(width: 15),
                            defaulTextButton(
                              function: () {
                                FirebaseAuth.instance.currentUser
                                    ?.sendEmailVerification()
                                    .then((value) {
                                  ShowToast(
                                      text: 'Check your mail',
                                      state: ToastStates.SUCCESS);
                                }).catchError(() {});
                              },
                              text: 'Send',
                            ),
                          ],
                        ),
                      ),
                    )
              
*/
