// ignore_for_file: must_be_immutable, prefer_is_empty

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chat_app/models/message_model.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/shared/styles/colors.dart';
import 'package:chat_app/shared/styles/icon_broken.dart';

import '../../layout/social_app/cubit/cubit.dart';
import '../../layout/social_app/cubit/states.dart';

class ChatDetailsScreen extends StatelessWidget {
  UserModel? userModel;
  ChatDetailsScreen({super.key, this.userModel});
  var messageCntrlr = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      ChatCubit.get(context).getMessages(receiverId: userModel!.uId!);
      return BlocConsumer<ChatCubit, ChatStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              titleSpacing: 0.0,
              title: Row(
                children: [
                  CircleAvatar(
                    radius: 20.0,
                    backgroundImage: NetworkImage(userModel!.image!),
                  ),
                  const SizedBox(width: 15),
                  Text(userModel!.name!),
                ],
              ),
            ),
            body: ConditionalBuilder(
              condition: ChatCubit.get(context).messages.length > 0,
              builder: (context) => Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          var message = ChatCubit.get(context).messages[index];
                          if (ChatCubit.get(context).userModel!.uId ==
                              message.senderId) return buildMyMessage(message);
                          return buildMessage(message);
                        },
                        separatorBuilder: (context, index) => const SizedBox(height: 15),
                        itemCount: ChatCubit.get(context).messages.length,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey.withOpacity(0.5),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Row(
                        children: [
                          const SizedBox(width: 5),
                          Expanded(
                            child: TextFormField(
                              controller: messageCntrlr,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Type Your message Here ...',
                              ),
                            ),
                          ),
                          Container(
                            height: 50,
                            color: defaultColor,
                            child: MaterialButton(
                              minWidth: 1,
                              onPressed: () {
                                ChatCubit.get(context).SendMessage(
                                  receiverId: userModel!.uId!,
                                  dateTime: DateTime.now().toString(),
                                  text: messageCntrlr.text,
                                );
                              },
                              child: const Icon(
                                IconBroken.Send,
                                size: 16,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              fallback: (context) => const Center(child: CircularProgressIndicator()),
            ),
          );
        },
      );
    });
  }

  Widget buildMessage(MessageModel model) => Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 10,
          ),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: const BorderRadiusDirectional.only(
              bottomEnd: Radius.circular(10.0),
              topStart: Radius.circular(10.0),
              topEnd: Radius.circular(10.0),
            ),
          ),
          child: Text(model.text!),
        ),
      );
  Widget buildMyMessage(MessageModel model) => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 10,
          ),
          decoration: BoxDecoration(
            color: defaultColor.withOpacity(.6),
            borderRadius: const BorderRadiusDirectional.only(
              bottomStart: Radius.circular(10.0),
              topStart: Radius.circular(10.0),
              topEnd: Radius.circular(10.0),
            ),
          ),
          child: Text(model.text!),
        ),
      );
}
