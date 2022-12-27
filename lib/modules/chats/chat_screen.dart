// ignore_for_file: prefer_is_empty

import 'package:chat_app/layout/social_app/cubit/cubit.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/modules/chat_details/chat_details_screen.dart';
import 'package:chat_app/shared/components/components.dart';
import 'package:chat_app/shared/cubit/appcubit/cubit.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/social_app/cubit/states.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatCubit, ChatStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: ChatCubit.get(context).users.length > 0,
          builder: (context) => ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) =>
                buildChatItem(ChatCubit.get(context).users[index], context),
            separatorBuilder: (context, index) => myDivder(),
            itemCount: ChatCubit.get(context).users.length,
          ),
          fallback: (context) => const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildChatItem(UserModel model, context) => InkWell(
        onTap: () {
          AppCubit.get(context).navigateTo(
            context,
            ChatDetailsScreen(userModel: model),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(
                  '${model.image}',
                ),
              ),
              const SizedBox(width: 15),
              Text(
                '${model.name}',
                style: const TextStyle(height: 1.4),
              ),
            ],
          ),
        ),
      );
}
