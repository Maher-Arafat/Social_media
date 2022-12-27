import 'package:chat_app/modules/edit_profile/edit_profile.dart';
import 'package:chat_app/shared/components/constants.dart';
import 'package:chat_app/shared/cubit/appcubit/cubit.dart';
import 'package:chat_app/shared/styles/icon_broken.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/social_app/cubit/cubit.dart';
import '../../layout/social_app/cubit/states.dart';
import '../native_code.dart';

class SettingssScreen extends StatelessWidget {
  const SettingssScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatCubit, ChatStates>(
      listener: (context, state) => {},
      builder: (context, state) {
        var usermodel = ChatCubit.get(context).userModel;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 190,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Align(
                      alignment: AlignmentDirectional.topCenter,
                      child: Container(
                        height: 140,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(4),
                            topRight: Radius.circular(4),
                          ),
                          image: DecorationImage(
                            image: NetworkImage('${usermodel!.cover}'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    CircleAvatar(
                      radius: 64,
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage('${usermodel.image}'),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              Text(
                '${usermodel.name}',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              Text(
                '${usermodel.bio}',
                style: Theme.of(context).textTheme.caption,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              '100',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            Text(
                              'Posts',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                        onTap: () {},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              '378',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            Text(
                              'Photos',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                        onTap: () {},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              '100',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            Text(
                              'Following',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                        onTap: () {},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              '10k',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            Text(
                              'Followers',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      child: const Text('Add Photos'),
                      onPressed: () {},
                    ),
                  ),
                  const SizedBox(width: 10),
                  OutlinedButton(
                    child: const Icon(
                      IconBroken.Edit,
                      size: 14,
                    ),
                    onPressed: () {
                      AppCubit.get(context).navigateTo(
                        context,
                        EditProfileScreen(),
                      );
                    },
                  ),
                ],
              ),
              
              Row(
                children: [
                  OutlinedButton(
                    onPressed: () {
                      FirebaseMessaging.instance
                          .subscribeToTopic('announcements');
                    },
                    child: const Text('Subscribe'),
                  ),
                  const Spacer(),
                  const SizedBox(width: 20),
                  OutlinedButton(
                    onPressed: () {
                      FirebaseMessaging.instance
                          .unsubscribeFromTopic('announcements');
                    },
                    child: const Text('UnSubscribe'),
                  ),
                ],
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      AppCubit.get(context)
                          .navigateTo(context, NativeCodeScreen());
                    },
                    child: const Text('Battery level'),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      signOut(context);
                    },
                    child: const Text('Sign Out'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
