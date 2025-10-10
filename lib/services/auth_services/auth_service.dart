import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static Stream<User?> get userChanges => _auth.authStateChanges();

  static Future<User?> signUp(String email, String password) async {
    try {
      print("👉 Sign in start: $email");
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print("✅ Sign in success: ${credential.user?.email}");
      return credential.user;
    } on FirebaseAuthException catch (e) {
      // 🔴 Перетворюємо помилки Firebase у зрозумілий текст
      throw Exception(_handleFirebaseError(e));
    } catch (e) {
      throw Exception("Невідома помилка: $e");
    }
    return null;
  }

  static Future<User?> signIn(String email, String password) async {
    try {
      print("👉 Sign in start: $email");
      UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } on FirebaseAuthException catch (e) {
      // 🔴 Перетворюємо помилки Firebase у зрозумілий текст
      throw Exception(_handleFirebaseError(e));
    } catch (e) {
      throw Exception("Невідома помилка: $e");
    }
    return null;
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
