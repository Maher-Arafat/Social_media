
// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chat_app/layout/social_app/cubit/cubit.dart';
import 'package:chat_app/layout/social_app/cubit/states.dart';
import 'package:chat_app/shared/components/components.dart';
import 'package:chat_app/shared/styles/icon_broken.dart';

class EditProfileScreen extends StatelessWidget {
  var nameCntrler = TextEditingController();
  var phoneCntrler = TextEditingController();
  var bioCntrler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatCubit, ChatStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = ChatCubit.get(context).userModel!;
        var profileImage = ChatCubit.get(context).profileImage;
        var coverImage = ChatCubit.get(context).coverImage;
        nameCntrler.text = userModel.name!;
        bioCntrler.text = userModel.bio!;
        phoneCntrler.text = userModel.phone!;
        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            title: 'Edit Profile',
            actions: [
              defaulTextButton(
                function: () {
                  ChatCubit.get(context).updateUser(
                    name: nameCntrler.text,
                    phone: phoneCntrler.text,
                    bio: bioCntrler.text,
                  );
                },
                text: 'Update',
              ),
              const SizedBox(width: 10),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if (state is ChatUpdateLoadingState)
                    const LinearProgressIndicator(),
                  //if(state is ChatUpdateLoadingState)
                  SizedBox(
                    height: 190,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                height: 140,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(4),
                                    topRight: Radius.circular(4),
                                  ),
                                  image: DecorationImage(
                                    image: coverImage == null
                                        ? NetworkImage('${userModel.cover}')
                                        : FileImage(coverImage)
                                            as ImageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  ChatCubit.get(context).getCoverImage();
                                },
                                icon: const CircleAvatar(
                                  radius: 20,
                                  child: Icon(
                                    IconBroken.Camera,
                                    size: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 64,
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              child: CircleAvatar(
                                radius: 60,
                                backgroundImage: profileImage == null
                                    ? NetworkImage('${userModel.image}')
                                    : FileImage(profileImage) as ImageProvider,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                ChatCubit.get(context).getProfileImage();
                              },
                              icon: const CircleAvatar(
                                radius: 20,
                                child: Icon(
                                  IconBroken.Camera,
                                  size: 16,
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (ChatCubit.get(context).profileImage != null ||
                      ChatCubit.get(context).coverImage != null)
                    Row(
                      children: [
                        if (ChatCubit.get(context).profileImage != null)
                          Expanded(
                            child: Column(
                              children: [
                                defaultButton(
                                  function: () {
                                    ChatCubit.get(context).uploadProfileImage(
                                      name: nameCntrler.text,
                                      phone: phoneCntrler.text,
                                      bio: bioCntrler.text,
                                    );
                                  },
                                  text: 'Upload Profile',
                                ),
                                if (state is ChatUpdateLoadingState)
                                  const SizedBox(height: 5),
                                if (state is ChatUpdateLoadingState)
                                  const LinearProgressIndicator(),
                              ],
                            ),
                          ),
                        const SizedBox(width: 5.0),
                        if (ChatCubit.get(context).coverImage != null)
                          Expanded(
                            child: Column(
                              children: [
                                defaultButton(
                                  function: () {
                                    ChatCubit.get(context).uploadCoverImage(
                                      name: nameCntrler.text,
                                      phone: phoneCntrler.text,
                                      bio: bioCntrler.text,
                                    );
                                  },
                                  text: 'Upload Cover',
                                ),
                                if (state is ChatUpdateLoadingState)
                                  const SizedBox(height: 5),
                                if (state is ChatUpdateLoadingState)
                                  const LinearProgressIndicator(),
                              ],
                            ),
                          ),
                      ],
                    ),
                  if (ChatCubit.get(context).profileImage != null ||
                      ChatCubit.get(context).coverImage != null)
                    const SizedBox(height: 20),
                  defultFormField(
                    controller: nameCntrler,
                    type: TextInputType.name,
                    validate: (value) {
                      if (value!.isEmpty) return 'Name must not be Empty';
                      return null;
                    },
                    label: 'Name',
                    prefix: IconBroken.User,
                  ),
                  const SizedBox(height: 10),
                  defultFormField(
                    controller: bioCntrler,
                    type: TextInputType.text,
                    validate: (value) {
                      if (value!.isEmpty) return 'Bio must not be Empty';
                      return null;
                    },
                    label: 'Bio',
                    prefix: IconBroken.Info_Circle,
                  ),
                  const SizedBox(height: 20),
                  defultFormField(
                    controller: phoneCntrler,
                    type: TextInputType.number,
                    validate: (value) {
                      if (value!.isEmpty) return 'Phone must not be Empty';
                      return null;
                    },
                    label: 'Phone',
                    prefix: IconBroken.Call,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
