// ignore_for_file: must_be_immutable, prefer_is_empty

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:chat_app/layout/social_app/cubit/cubit.dart';
import 'package:chat_app/layout/social_app/cubit/states.dart';
import 'package:chat_app/shared/styles/colors.dart';
import 'package:chat_app/shared/styles/icon_broken.dart';

import '../../models/post_model.dart';

class FeedsScreen extends StatelessWidget {
  FeedsScreen({super.key});
  var txtCntrlr = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatCubit, ChatStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: ChatCubit.get(context).posts.length > 0 &&
              ChatCubit.get(context).userModel != null,
          builder: (context) => RefreshIndicator(
            onRefresh: () => ChatCubit.get(context).onRefresh(),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    elevation: 5,
                    margin: const EdgeInsets.all(8),
                    child: Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        const Image(
                          image: NetworkImage(
                              'https://img.freepik.com/free-photo/business-women-signature-document_1388-90.jpg?size=626&ext=jpg&ga=GA1.2.680799210.1670709065'),
                          fit: BoxFit.cover,
                          height: 200,
                          width: double.infinity,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Communicate with friends',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1
                                ?.copyWith(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => buildPostItem(
                        ChatCubit.get(context).posts[index], context, index),
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 8),
                    itemCount: ChatCubit.get(context).posts.length,
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
  Widget buildPostItem(PostModel model, context, index) => Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 5,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(
                      '${model.image}',
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              '${model.name}',
                              style: const TextStyle(height: 1.4),
                            ),
                            const SizedBox(width: 10),
                            Icon(
                              Icons.check_circle,
                              color: defaultColor,
                              size: 16,
                            ),
                          ],
                        ),
                        Text(
                          DateFormat('yyyy-MM-dd HH:mm')
                              .format(dateFormat.parse(model.dateTime!)),
                          style: Theme.of(context)
                              .textTheme
                              .caption
                              ?.copyWith(height: 1.4),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 15),
                  buildPobMenu(),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Container(
                  width: double.infinity,
                  height: 1.0,
                  color: Colors.grey[300],
                ),
              ),
              Text(
                '${model.text}',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              // Padding(
              //   padding: const EdgeInsets.only(bottom: 10, top: 5),
              //   child: Container(
              //     width: double.infinity,
              //     child: Wrap(
              //       children: [
              //         Padding(
              //           padding: const EdgeInsetsDirectional.only(end: 7),
              //           child: Container(
              //             height: 25,
              //             child: MaterialButton(
              //               minWidth: 1,
              //               padding: EdgeInsets.zero,
              //               onPressed: () {},
              //               child: Text(
              //                 '#Software',
              //                 style: Theme.of(context)
              //                     .textTheme
              //                     .caption
              //                     ?.copyWith(color: defaultColor),
              //               ),
              //             ),
              //           ),
              //         ),
              //         Padding(
              //           padding: const EdgeInsetsDirectional.only(end: 7),
              //           child: Container(
              //             height: 25,
              //             child: MaterialButton(
              //               minWidth: 1,
              //               padding: EdgeInsets.zero,
              //               onPressed: () {},
              //               child: Text(
              //                 '#flutter',
              //                 style: Theme.of(context)
              //                     .textTheme
              //                     .caption
              //                     ?.copyWith(color: defaultColor),
              //               ),
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              if (model.postImage != '')
                Padding(
                  padding: const EdgeInsetsDirectional.only(top: 15),
                  child: Container(
                    height: 140,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.0),
                        image: DecorationImage(
                          image: NetworkImage('${model.postImage}'),
                          fit: BoxFit.cover,
                        )),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            children: [
                              const Icon(
                                IconBroken.Heart,
                                color: Colors.red,
                                size: 18,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                '${ChatCubit.get(context).likes[index]}',
                                style: Theme.of(context).textTheme.caption,
                              )
                            ],
                          ),
                        ),
                        onTap: () {},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Icon(
                                IconBroken.Chat,
                                color: Colors.red,
                                size: 18,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                ///${ChatCubit.get(context).comments[index]}
                                '0 Comments',
                                style: Theme.of(context).textTheme.caption,
                              )
                            ],
                          ),
                        ),
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Container(
                  width: double.infinity,
                  height: 1.0,
                  color: Colors.grey[300],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundImage: NetworkImage(
                              '${ChatCubit.get(context).userModel!.image}',
                            ),
                          ),
                          const SizedBox(width: 15),
                          Text(
                            'Write a Comment ...',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                      onTap: () {
                        ///
                        //ChatCubit.get(context).CommentsPost(ChatCubit.get(context).postsId[index]);
                      },
                    ),
                  ),
                  InkWell(
                    child: Row(
                      children: [
                        const Icon(
                          IconBroken.Heart,
                          color: Colors.red,
                          size: 18,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          'Like',
                          style: Theme.of(context).textTheme.caption,
                        )
                      ],
                    ),
                    onTap: () {
                      ChatCubit.get(context)
                          .LikePost(ChatCubit.get(context).postsId[index]);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      );
 
  buildPobMenu() => PopupMenuButton(
        itemBuilder: (BuildContext context) => <PopupMenuEntry>[
          const PopupMenuItem(
            value: 1,
            child: Text('Delete'),
            
          ),
          const PopupMenuItem(
            value: 2,
            child: Text('Edit'),
          ),
        ],
      );
}
