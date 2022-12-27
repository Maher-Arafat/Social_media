// ignore_for_file: must_be_immutable, avoid_print

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chat_app/layout/social_app/chat_layout.dart';
import 'package:chat_app/modules/register/cubit/cubit.dart';
import 'package:chat_app/modules/register/cubit/states.dart';

import '../../../../shared/components/components.dart';
import '../../shared/cubit/appcubit/cubit.dart';

class ChatRegisterScreen extends StatelessWidget {
  var formKy = GlobalKey<FormState>();
  var emailCntrlr = TextEditingController();
  var phoneCntrlr = TextEditingController();
  var nameCntrlr = TextEditingController();
  var passowrdCntrlr = TextEditingController();

  ChatRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatRegisterCubit(),
      child: BlocConsumer<ChatRegisterCubit, ChatRegisterStates>(
        listener: (context, state) {
          if (state is ChatCreateUserSuccessState) {
            AppCubit.get(context).navigateFinish(context, const ChatLayOut());
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
                        //if (state is! ChatLoadingUpdateUserState)
                        //const LinearProgressIndicator(),
                        const SizedBox(height: 15),
                        Text(
                          'REGISTER',
                          style: Theme.of(context)
                              .textTheme
                              .headline4
                              ?.copyWith(color: Colors.teal),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          'Register now to communicate with friends',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(color: Colors.grey, fontSize: 14.8),
                        ),
                        const SizedBox(height: 30),
                        defultFormField(
                          controller: nameCntrlr,
                          type: TextInputType.name,
                          validate: (String? val) {
                            if (val!.isEmpty) {
                              return 'Please Enter your Name';
                            }
                            return null;
                          },
                          label: 'Name',
                          prefix: Icons.person,
                        ),
                        const SizedBox(height: 30),
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
                          sufix: ChatRegisterCubit.get(context).suffix,
                          sufixPressed: () {
                            ChatRegisterCubit.get(context)
                                .changePasswordVisibility();
                          },
                          isPassword: ChatRegisterCubit.get(context).isPassword,

                          /*onSubmit: (p0) {
                            if (formKy.currentState!.validate()) {
                              ChatRegisterCubit.get(context).userRegister(
                                email: emailCntrlr.text,
                                name: nameCntrlr.text,
                                phone: phoneCntrlr.text,
                                password: passowrdCntrlr.text,
                              );
                            }
                          },
                          */
                          validate: (String? val) {
                            if (val!.isEmpty) {
                              return 'Password is too short';
                            }
                            return null;
                          },
                          label: 'Password',
                          prefix: Icons.lock_outline,
                        ),
                        const SizedBox(height: 30),
                        defultFormField(
                          controller: phoneCntrlr,
                          type: TextInputType.phone,
                          validate: (String? val) {
                            if (val!.isEmpty) {
                              return 'Please Enter your Email Address';
                            }
                            return null;
                          },
                          label: 'Phone Number',
                          prefix: Icons.phone,
                        ),
                        const SizedBox(height: 15),
                        ConditionalBuilder(
                          condition: state is! ChatRegisterLoadingState,
                          builder: (context) => defaultButton(
                              function: () {
                                if (formKy.currentState!.validate()) {
                                  ChatRegisterCubit.get(context).userRegister(
                                    email: emailCntrlr.text,
                                    name: nameCntrlr.text,
                                    phone: phoneCntrlr.text,
                                    password: passowrdCntrlr.text,
                                  );
                                }
                              },
                              text: 'Register',
                              isUpperScase: true),
                          fallback: (context) =>
                              const Center(child: CircularProgressIndicator()),
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
