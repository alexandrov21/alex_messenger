import 'package:alex_messenger/bloc/chat_page_bloc/chat_page_event.dart';
import 'package:alex_messenger/services/chat_service/chat_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/chat_page_bloc/chat_page_bloc.dart';
import '../../bloc/chat_page_bloc/chat_page_state.dart';
import '../../utils/app_colors.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _messageController = TextEditingController();

  @override
  void dispose() {
    // 🧹 Звільняємо ресурси контролерів
    _messageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: BlocBuilder<ChatPageBloc, ChatPageState>(
          builder: (context, state) {
            if (state is ChatPageOpenedState) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    state.otherUser.fullName,
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              );
            } else if (state is ChatPageLoadingState) {
              return Text('Loading...');
            } else {
              return Text('Chat');
            }
          },
        ),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.keyboard_backspace_outlined, color: Colors.white),
        ),
        actions: [
          BlocBuilder<ChatPageBloc, ChatPageState>(
            builder: (context, state) {
              if (state is ChatPageOpenedState) {
                return Padding(
                  padding: EdgeInsets.only(right: 12),
                  child: _buildAvatar(
                    state.otherUser.fullName,
                    state.otherUser.uid!,
                  ),
                );
              } else {
                return SizedBox();
              }
            },
          ),
        ],
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [Colors.indigo, Colors.blue]),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(child: _buildMessageList()),
          _buildInputMessage(),
        ],
      ),
    );
  }

  Widget _buildAvatar(String fullName, String uid) {
    final parts = fullName.trim().split(" ");

    String initials = "";
    if (parts.isNotEmpty) initials += parts[0][0];
    if (parts.length > 1) initials += parts[1][0];

    final color = AppColors.generateStableColor(uid);
    final bgColor = AppColors.adjustColorForText(color);

    return CircleAvatar(
      radius: 20,
      backgroundColor: bgColor,
      child: Text(
        initials.toUpperCase(),
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _buildInputMessage() {
    return Padding(
      padding: EdgeInsets.only(left: 12, bottom: 24, top: 12),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 16,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
                hintText: "Enter a message...",
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              final text = _messageController.text.trim();
              if (text.isEmpty) return;

              context.read<ChatPageBloc>().add(SendMessage(textMessage: text));
              _messageController.clear();
            },
            icon: Icon(Icons.send_rounded),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    return BlocBuilder<ChatPageBloc, ChatPageState>(
      builder: (context, state) {
        if (state is ChatPageLoadingState) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is! ChatPageOpenedState) {
          return SizedBox();
        }

        final messages = state.messages;
        final currentUser = state.currentUser;

        if (messages.isEmpty) {
          return Center(child: Text('No messages'));
        }

        return ListView.builder(
          itemCount: messages.length,
          itemBuilder: (context, index) {
            final message = messages[index];

            final isMe = message.senderId == currentUser.uid;
            return Align(
              alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                decoration: BoxDecoration(
                  color: isMe ? Colors.blue : Colors.grey[300],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                    bottomLeft: isMe ? Radius.circular(12) : Radius.circular(0),
                    bottomRight: isMe
                        ? Radius.circular(0)
                        : Radius.circular(12),
                  ),
                ),
                child: Text(
                  message.text,
                  style: TextStyle(color: isMe ? Colors.white : Colors.black87),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
