import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/app_user.dart';

class FirebaseService {
  static final FirebaseFirestore _database = FirebaseFirestore.instance;
  static final CollectionReference users = _database.collection('users');

  static Future<void> saveUser(AppUser user) async {
    await _database.collection('users').doc(user.uid).set(user.toMap());
  }

  static Future<AppUser?> getUserByUid(String uid) async {
    final doc = await users.doc(uid).get();

    if (!doc.exists) return null;

    return AppUser.fromMap(doc.data() as Map<String, dynamic>);
  }

  static Future<void> updateUser(AppUser user) async {
    await _database.collection('users').doc(user.uid).update(user.toMap());
  }

  static Future<List<AppUser>> getAllUsersExcept(String currentUid) async {
    final query = await _database
        .collection('users')
        .where('uid', isNotEqualTo: currentUid)
        .get();

    return query.docs.map((doc) => AppUser.fromMap(doc.data())).toList();
  }
}
