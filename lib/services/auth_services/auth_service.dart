import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static Stream<User?> get userChanges => _auth.authStateChanges();

  static Future<User?> signUp(String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } on FirebaseAuthException catch (e) {
      print('🔥 ERRORRRRRRRRRRFirebaseAuthException.code = ${e.code}');
      print('🔥 ERRORRRRRRRRRRFirebaseAuthException.message = ${e.message}');
      if (e.code == 'email-already-in-use') {
        throw Exception('Ця адреса вже зареєстрована.');
      } else if (e.code == 'invalid-email') {
        throw Exception('Некоректний формат email.');
      } else if (e.code == 'user-disabled') {
        throw Exception('Обліковий запис користувача деактивовано.');
      } else if (e.code == 'weak-password') {
        throw Exception('Пароль занадто слабкий.');
      } else {
        throw Exception('Помилка входу: ${e.message}');
      }
    }
    return null;
  }

  static Future<User?> signIn(String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential') {
        throw Exception('Неправильний логін або пароль.');
      } else if (e.code == 'invalid-email') {
        throw Exception('Некоректний формат email.');
      } else if (e.code == 'user-disabled') {
        throw Exception('Обліковий запис користувача деактивовано.');
      } else {
        throw Exception('Помилка входу: ${e.message}');
      }
    }
  }

  static Future<void> signOut() async {
    await _auth.signOut();
  }

  static String _handleFirebaseError(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'Користувача не знайдено';
      case 'wrong-password':
        return 'Невірний пароль';
      case 'invalid-email':
        return 'Некоректна адреса електронної пошти';
      case 'email-already-in-use':
        return 'Ця адреса вже зареєстрована';
      case 'weak-password':
        return 'Пароль занадто слабкий';
      case 'too-many-requests':
        return 'Забагато спроб входу. Спробуйте пізніше';
      default:
        return 'Сталася помилка: ${e.message}';
    }
  }
}
