import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/app_user.dart';

class ChatService {
  static final FirebaseFirestore _database = FirebaseFirestore.instance;
  static final CollectionReference _chats = _database.collection('chats');

  static CollectionReference messages(String chatId) =>
      _chats.doc(chatId).collection('messages');

  static Future<void> sendMessage({
    required String chatId,
    required String senderUid,
    required String senderFullName,
    required String text,
  }) async {
    await messages(chatId).add({
      'senderId': senderUid,
      'senderName': senderFullName,
      'text': text,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  static Future<String> getOrCreateChat(
    String currentUid,
    String otherUid,
  ) async {
    final members = [currentUid, otherUid]..sort();

    //find chat
    final query = await _database
        .collection('chats')
        .where('members', isEqualTo: members)
        .limit(1)
        .get();

    //if chat is
    if (query.docs.isNotEmpty) {
      return query.docs.first.id;
    }

    final chatDoc = await _database.collection('chats').add({
      'members': members,
      'createdAt': FieldValue.serverTimestamp(),
    });

    return chatDoc.id;
  }

  static Stream<QuerySnapshot> messagesStream(String chatId) {
    return messages(chatId).orderBy('createdAt', descending: false).snapshots();
  }
}
