import 'package:alex_messenger/models/app_user.dart';
import 'package:alex_messenger/models/message_model.dart';

class ChatPageState {}

class ChatPageInitialState extends ChatPageState {}

class ChatPageLoadingState extends ChatPageState {}

class ChatPageOpenedState extends ChatPageState {
  final AppUser currentUser;
  final AppUser otherUser;
  final String chatId;
  final List<MessageModel> messages;

  ChatPageOpenedState({
    required this.currentUser,
    required this.otherUser,
    required this.chatId,
    required this.messages,
  });
}

class ChatPageErrorState extends ChatPageState {
  final String errorMessage;

  ChatPageErrorState(this.errorMessage);
}
