// ignore_for_file: must_be_immutable

import 'package:chat_app/layout/social_app/cubit/cubit.dart';
import 'package:chat_app/layout/social_app/cubit/states.dart';
import 'package:chat_app/modules/feeds/feeds_screen.dart';
import 'package:chat_app/shared/components/components.dart';
import 'package:chat_app/shared/cubit/appcubit/cubit.dart';
import 'package:chat_app/shared/styles/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


// ignore: use_key_in_widget_constructors
class NewPostScreen extends StatelessWidget {
  var textCntrlr = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatCubit, ChatStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            title: 'Create Post',
            actions: [
              defaulTextButton(
                function: () {
                  var now = DateTime.now();
                  if (ChatCubit.get(context).posTImage == null) {
                    ChatCubit.get(context).createPost(
                      dateTime: now.toString(),
                      text: textCntrlr.text,
                    );
                  } else if (ChatCubit.get(context).posTImage != null) {
                    ChatCubit.get(context).UpLoadPostImage(
                      dateTime: now.toString(),
                      text: textCntrlr.text,
                    );
                  }
                  ChatCubit.get(context).getPosts();
                  AppCubit.get(context).navigateTo(context, FeedsScreen());
                },
                text: 'Post',
              ),
              const SizedBox(width: 8),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (state is ChatCreatePostLoadingState)
                  const LinearProgressIndicator(),
                if (state is ChatCreatePostLoadingState) const SizedBox(height: 10),
                Row(
                  children:const [
                     CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(
                        'https://img.freepik.com/free-photo/waist-up-portrait-handsome-serious-unshaven-male-keeps-hands-together-dressed-dark-blue-shirt-has-talk-with-interlocutor-stands-against-white-wall-self-confident-man-freelancer_273609-16320.jpg?size=626&ext=jpg&ga=GA1.2.680799210.1670709065&semt=sph',
                      ),
                    ),
                     SizedBox(width: 15),
                     Expanded(
                      child: Text(
                        'Ahmed Ali',
                        style: TextStyle(height: 1.4),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    controller: textCntrlr,
                    decoration: const InputDecoration(
                        hintText: 'What is on your mind,',
                        border: InputBorder.none),
                  ),
                ),
                //const SizedBox(height: 20),
                if (ChatCubit.get(context).posTImage != null)
                  Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Container(
                        height: 140,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          image: DecorationImage(
                            image: FileImage(ChatCubit.get(context).posTImage!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          ChatCubit.get(context).removePostImage();
                        },
                        icon: const CircleAvatar(
                          radius: 20,
                          child: Icon(
                            Icons.close,
                            size: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                          onPressed: () {
                            ChatCubit.get(context).getPostImage();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:const [
                               Icon(IconBroken.Image),
                               SizedBox(width: 5),
                               Text(
                                'Add Photo',
                              ),
                            ],
                          )),
                    ),
                    Expanded(
                      child: TextButton(
                          onPressed: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:const [
                               Text(
                                '# Tags',
                              ),
                            ],
                          )),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
