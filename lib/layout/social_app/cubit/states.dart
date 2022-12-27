abstract class ChatStates {}

class ChatInitialState extends ChatStates {}

class ChatGetUserLoadingState extends ChatStates {}

class ChatGetUserSuccessState extends ChatStates {}

class ChatGetUserErrorState extends ChatStates {
  final String error;
  ChatGetUserErrorState(this.error);
}

class ChatGetAllUserLoadingState extends ChatStates {}

class ChatGetAllUserSuccessState extends ChatStates {}

class ChatGetAllUserErrorState extends ChatStates {
  final String error;
  ChatGetAllUserErrorState(this.error);
}

class ChatGetPostsLoadingState extends ChatStates {}

class ChatGetPostsSuccessState extends ChatStates {}

class ChatGetPostsErrorState extends ChatStates {
  final String error;
  ChatGetPostsErrorState(this.error);
}

class ChatChangeBotttomNavState extends ChatStates {}

class ChatNewPostState extends ChatStates {}

class ChatProfileImagePickedSuccessState extends ChatStates {}

class ChatProfileImagePickedErrorState extends ChatStates {}

class ChatCoverImagePickedSuccessState extends ChatStates {}

class ChatCoverImagePickedErrorState extends ChatStates {}

class ChatUploadProfileImageSuccessState extends ChatStates {}

class ChatUploadProfileImageErrorState extends ChatStates {}

class ChatUploadCoverImageSuccessState extends ChatStates {}

class ChatUploadCoverImageErrorState extends ChatStates {}

class ChatUpdateErrorState extends ChatStates {}

class ChatUpdateLoadingState extends ChatStates {}

class ChatLikePostSuccessState extends ChatStates {}

class ChatLikePostErrorState extends ChatStates {
  final String error;
  ChatLikePostErrorState(this.error);
}

class ChatCommentSuccessState extends ChatStates {}

class ChatCommentErrorState extends ChatStates {
  final String error;
  ChatCommentErrorState(this.error);
}

//Create post
class ChatCreatePostLoadingState extends ChatStates {}

class ChatCreatePostSuccessState extends ChatStates {}

class ChatCreatePostErrorState extends ChatStates {}

class ChatPostImagePickedSuccessState extends ChatStates {}

class ChatPostImagePickedErrorState extends ChatStates {}

class ChatRemovePostImageState extends ChatStates {}

//Chat
class ChatSendMessageSuccessState extends ChatStates {}

class ChatSendMessageErrorState extends ChatStates {
  final String error;
  ChatSendMessageErrorState(this.error);
}

class ChatGetAllMessagesSuccessState extends ChatStates {}

class ChatGetAllMessagesErrorState extends ChatStates {
  final String error;
  ChatGetAllMessagesErrorState(this.error);
}
