import 'dart:async';

import 'package:alex_messenger/bloc/chat_page_bloc/chat_page_event.dart';
import 'package:alex_messenger/bloc/chat_page_bloc/chat_page_state.dart';
import 'package:alex_messenger/models/message_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/chat_service/chat_service.dart';

class ChatPageBloc extends Bloc<ChatPageEvent, ChatPageState> {
  StreamSubscription? _messagesSub;

  ChatPageBloc() : super(ChatPageInitialState()) {
    on<ChatPageOpened>(_onChatOpened);
    on<SendMessage>(_onSendMessage);
    on<MessagesUpdated>(_onMessagesUpdated);
  }

  Future<void> _onChatOpened(
    ChatPageOpened event,
    Emitter<ChatPageState> emit,
  ) async {
    emit(ChatPageLoadingState());
    final currentUser = event.currentUser;
    final otherUser = event.otherUser;

    final chatId = await ChatService.getOrCreateChat(
      currentUser.uid!,
      otherUser.uid!,
    );

    _messagesSub?.cancel();
    _messagesSub = ChatService.messagesStream(chatId).listen(
      (snapshot) {
        final messages = snapshot.docs
            .map(
              (doc) => MessageModel.fromMap(doc.data() as Map<String, dynamic>),
            )
            .toList();
        add(MessagesUpdated(messages: messages));
      },
      onError: (e) {
        emit(ChatPageErrorState(e.toString()));
      },
    );

    emit(
      ChatPageOpenedState(
        currentUser: currentUser,
        otherUser: otherUser,
        chatId: chatId,
        messages: [],
      ),
    );
  }

  Future<void> _onSendMessage(
    SendMessage event,
    Emitter<ChatPageState> emit,
  ) async {
    final text = event.textMessage.trim();

    if (text.isEmpty) {
      return;
    }

    if (state is! ChatPageOpenedState) return;

    try {
      final openedState = state as ChatPageOpenedState;

      await ChatService.sendMessage(
        chatId: openedState.chatId,
        senderUid: openedState.currentUser.uid!,
        text: text,
      );
    } catch (e) {
      emit(ChatPageErrorState(e.toString()));
    }
  }

  void _onMessagesUpdated(MessagesUpdated event, Emitter<ChatPageState> emit) {
    if (state is! ChatPageOpenedState) return;

    final s = state as ChatPageOpenedState;

    emit(
      ChatPageOpenedState(
        currentUser: s.currentUser,
        otherUser: s.otherUser,
        chatId: s.chatId,
        messages: event.messages,
      ),
    );
  }
}
