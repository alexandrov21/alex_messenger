import 'package:alex_messenger/models/app_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/message_model.dart';

class ChatPageEvent {}

class ChatPageOpened extends ChatPageEvent {
  final AppUser currentUser;
  final AppUser otherUser;

  ChatPageOpened({required this.currentUser, required this.otherUser});
}

class SendMessage extends ChatPageEvent {
  final String textMessage;

  SendMessage({required this.textMessage});
}

class MessagesUpdated extends ChatPageEvent {
  final List<MessageModel> messages;

  MessagesUpdated({required this.messages});
}
