// ignore_for_file: avoid_print, non_constant_identifier_names, avoid_function_literals_in_foreach_calls, prefer_is_empty

import 'dart:io';

import 'package:chat_app/models/message_model.dart';
import 'package:chat_app/models/post_model.dart';
import 'package:chat_app/modules/chats/chat_screen.dart';
import 'package:chat_app/modules/feeds/feeds_screen.dart';
import 'package:chat_app/modules/new_post/new_post_screen.dart';
import 'package:chat_app/modules/settings/settings_screen.dart';
import 'package:chat_app/modules/notification/notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chat_app/layout/social_app/cubit/states.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/shared/components/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firbase_storage;

class ChatCubit extends Cubit<ChatStates> {
  ChatCubit() : super(ChatInitialState());

  static ChatCubit get(context) => BlocProvider.of(context);

  UserModel? userModel;

  void getUserData() {
    emit(ChatGetUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      //print(value.data());
      //print(uId);
      userModel = UserModel.fromJson(value.data()!);
      emit(ChatGetUserSuccessState());
    }).catchError((error) {
      emit(ChatGetUserErrorState(error.toString()));
    });
  }

  int crntIdx = 0;

  List<Widget> screns = [
    FeedsScreen(),
    const ChatsScreen(),
    NewPostScreen(),
    const NotificationScreen(),
    const SettingssScreen(),
  ];

  List<String> titls = [
    'Home',
    'Chats',
    'New Post',
    'Notifications',
    'Settings',
  ];

  void changBottomNav(int idx) {
    if (idx == 1) getAllUsers();
    if (idx == 2) {
      emit(ChatNewPostState());
    } else {
      crntIdx = idx;
      emit(ChatChangeBotttomNavState());
    }
  }

  File? profileImage;
  var picker = ImagePicker();

  Future<void> getProfileImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(ChatProfileImagePickedSuccessState());
    } else {
      print('No Image Selected');
      emit(ChatProfileImagePickedErrorState());
    }
  }

  File? coverImage;

  Future<void> getCoverImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(ChatCoverImagePickedSuccessState());
    } else {
      print('No Image Selected');
      emit(ChatCoverImagePickedErrorState());
    }
  }

  void uploadProfileImage({
    required String? name,
    required String? phone,
    required String? bio,
  }) {
    emit(ChatUpdateLoadingState());
    firbase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((val) {
      val.ref.getDownloadURL().then((value) {
        //emit(ChatUploadProfileImageSuccessState());
        print(value);
        updateUser(
          name: name,
          phone: phone,
          bio: bio,
          image: value,
        );
      }).catchError((error) {
        emit(ChatUploadProfileImageErrorState());
      });
    }).catchError((error) {
      emit(ChatUploadProfileImageErrorState());
    });
  }

  void uploadCoverImage({
    required String? name,
    required String? phone,
    required String? bio,
  }) {
    emit(ChatUpdateLoadingState());
    firbase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((val) {
      val.ref.getDownloadURL().then((value) {
        //emit(ChatUploadCoverImageSuccessState());
        print(value);
        updateUser(
          name: name,
          phone: phone,
          bio: bio,
          cover: value,
        );
      }).catchError((error) {
        emit(ChatUploadCoverImageErrorState());
      });
    }).catchError((error) {
      emit(ChatUploadCoverImageErrorState());
    });
  }

  // void updateUserImages({
  //   required String? name,
  //   required String? phone,
  //   required String? bio,
  // }) {
  //   emit(ChatUpdateLoadingState());
  //   if (coverImage != null) {
  //     uploadCoverImage();
  //   } else if (profileImage != null) {
  //     uploadProfileImage();
  //   } else if (coverImage != null && profileImage != null) {
  //   } else {
  //     updateUser(
  //       name: name,
  //       phone: phone,
  //       bio: bio,
  //     );
  //   }
  // }

  void updateUser({
    required String? name,
    required String? phone,
    required String? bio,
    String? cover,
    String? image,
  }) {
    UserModel model = UserModel(
      name: name,
      phone: phone,
      isEmailVrefied: false,
      bio: bio,
      email: userModel!.email,
      image: image ?? userModel!.image,
      cover: cover ?? userModel!.cover,
      uId: userModel!.uId,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .update(model.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      emit(ChatUpdateErrorState());
    });
  }

  File? posTImage;

  Future<void> getPostImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      posTImage = File(pickedFile.path);
      emit(ChatPostImagePickedSuccessState());
    } else {
      print('No Image Selected');
      emit(ChatPostImagePickedErrorState());
    }
  }

  void removePostImage() {
    posTImage = null;
    emit(ChatRemovePostImageState());
  }

  void UpLoadPostImage({
    required String? dateTime,
    required String? text,
  }) {
    emit(ChatCreatePostLoadingState());
    firbase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(posTImage!.path).pathSegments.last}')
        .putFile(posTImage!)
        .then((val) {
      val.ref.getDownloadURL().then((value) {
        print(value);
        createPost(
          dateTime: dateTime,
          text: text,
          postImage: value,
        );
      }).catchError((error) {
        emit(ChatCreatePostErrorState());
      });
    }).catchError((error) {
      emit(ChatCreatePostErrorState());
    });
  }

  void createPost({
    required String? dateTime,
    required String? text,
    String? postImage,
  }) {
    emit(ChatCreatePostLoadingState());
    PostModel model = PostModel(
      name: userModel!.name,
      image: userModel!.image,
      uId: userModel!.uId,
      dateTime: dateTime,
      text: text,
      postImage: postImage ?? '',
    );
    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
      emit(ChatCreatePostSuccessState());
    }).catchError((error) {
      emit(ChatCreatePostErrorState());
    });
  }

  List<PostModel> posts = [];
  List<String> postsId = [];
  List<int> likes = [];
  List<int> comments = [];
  void getPosts() {
    posts = [];
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach(
        (element) {
          element.reference.collection('likes').get().then((value) {
            likes.add(value.docs.length);
            postsId.add(element.id);
            posts.add(PostModel.fromJson(element.data()));
            // ignore: argument_type_not_assignable_to_error_handler
          }).catchError(() {
            print('Like Error');
          });
          // element.reference.collection('comments').get().then((value) {
          //   comments.add(value.docs.length);
          //   postsId.add(element.id);
          //   posts.add(PostModel.fromJson(element.data()));
          // }).catchError(() {
          //   print('Comment Error');
          // });
        },
      );
      emit(ChatGetPostsSuccessState());
    }).catchError((error) {
      emit(ChatGetPostsErrorState(error.toString()));
    });
  }

  void LikePost(String? postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel!.uId)
        .set({'like': true}).then((value) {
      emit(ChatLikePostSuccessState());
    }).catchError((error) {
      emit(ChatLikePostErrorState(error.toString()));
    });
  }

  void CommentsPost(String? postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .doc(userModel!.uId)
        .set({
      'comment': true,
    }).then((value) {
      emit(ChatCommentSuccessState());
    }).catchError((error) {
      emit(ChatCommentErrorState(error.toString()));
    });
  }

  List<UserModel> users = [];
  void getAllUsers() {
    if (users.length == 0) {
      FirebaseFirestore.instance.collection('users').get().then((value) {
        value.docs.forEach(
          (element) {
            if (element.data()['uId'] != userModel!.uId) {
              users.add(UserModel.fromJson(element.data()));
            }
          },
        );
        emit(ChatGetAllUserSuccessState());
      }).catchError((error) {
        emit(ChatGetAllUserErrorState(error.toString()));
      });
    }
  }

  void SendMessage({
    required String receiverId,
    required String dateTime,
    required String text,
  }) {
    MessageModel model = MessageModel(
      senderId: userModel!.uId,
      receiverId: receiverId,
      dateTime: dateTime,
      text: text,
    );
    //set my Chats
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(ChatSendMessageSuccessState());
    }).catchError((error) {
      emit(ChatSendMessageErrorState(error.toString()));
    });
    //set receiver Chats
    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(userModel!.uId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(ChatSendMessageSuccessState());
    }).catchError((error) {
      emit(ChatSendMessageErrorState(error.toString()));
    });
  }

  List<MessageModel> messages = [];

  void getMessages({
    required String receiverId,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId!)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = [];
      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
      });
      emit(ChatGetAllMessagesSuccessState());
    });
  }

  Future<void> onRefresh() async {
    getPosts();
  }
}
