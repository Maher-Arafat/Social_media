// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chat_app/layout/social_app/chat_layout.dart';
import 'package:chat_app/modules/login/cubit/cubit.dart';
import 'package:chat_app/modules/login/cubit/states.dart';
import 'package:chat_app/modules/register/chat_register_screen.dart';
import 'package:chat_app/network/local/cach_helper.dart';

import '../../shared/components/components.dart';
import '../../shared/cubit/appcubit/cubit.dart';

class ChatLoginScreen extends StatelessWidget {
  var formKy = GlobalKey<FormState>();
  var emailCntrlr = TextEditingController();
  var passowrdCntrlr = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatLoginCubit(),
      child: BlocConsumer<ChatLoginCubit, ChatLoginStates>(
        listener: (context, state) {
          if (state is ChatLoginErrorState) {
            ShowToast(text: state.error, state: ToastStates.ERROR);
          }
          if (state is ChatLoginSuccessState) {
            CacheHelper.saveDate(
              key: 'uId',
              value: state.uId,
            ).then((value) {
              AppCubit.get(context).navigateFinish(context, const ChatLayOut());
            });
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKy,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style: Theme.of(context)
                              .textTheme
                              .headline4
                              ?.copyWith(color: Colors.teal),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          'Login now to communicate with friends',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(color: Colors.grey, fontSize: 15.9),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        defultFormField(
                          controller: emailCntrlr,
                          type: TextInputType.emailAddress,
                          validate: (String? val) {
                            if (val!.isEmpty) {
                              return 'Please Enter your Email Address';
                            }
                            return null;
                          },
                          label: 'Email Address',
                          prefix: Icons.email_outlined,
                        ),
                        const SizedBox(height: 15),
                        defultFormField(
                          controller: passowrdCntrlr,
                          type: TextInputType.visiblePassword,
                          sufix: ChatLoginCubit.get(context).suffix,
                          sufixPressed: () {
                            ChatLoginCubit.get(context)
                                .changePasswordVisibility();
                          },
                          isPassword: ChatLoginCubit.get(context).isPassword,
                          onSubmit: (p0) {
                            if (formKy.currentState!.validate()) {
                              ChatLoginCubit.get(context).userLogin(
                                email: emailCntrlr.text,
                                password: passowrdCntrlr.text,
                              );
                            }
                          },
                          validate: (String? val) {
                            if (val!.isEmpty) {
                              return 'Password is too short';
                            }
                            return null;
                          },
                          label: 'Password',
                          prefix: Icons.lock_outline,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        ConditionalBuilder(
                          condition: true, //state is! ChatLoginLoadingState,
                          builder: (context) => defaultButton(
                              function: () {
                                if (formKy.currentState!.validate()) {
                                  ChatLoginCubit.get(context).userLogin(
                                    email: emailCntrlr.text,
                                    password: passowrdCntrlr.text,
                                  );
                                }
                              },
                              text: 'login',
                              isUpperScase: true),
                          fallback: (context) =>
                              const Center(child: CircularProgressIndicator()),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Don\'t have an account ?'),
                            defaulTextButton(
                              function: () {
                                AppCubit.get(context)
                                    .navigateTo(context, ChatRegisterScreen());
                              },
                              text: 'register',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
