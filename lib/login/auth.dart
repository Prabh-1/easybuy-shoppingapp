import 'package:easybuy/login/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:shared_preferences/shared_preferences.dart';

class Auth {
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;

  User? _firebaseUser(auth.User? user) {
    if (user == null) {
      return null;
    }
    return User(user.uid, user.email);
  }

  Stream<User?>? get user {
    return _firebaseAuth.authStateChanges().map(_firebaseUser);
  }

    Future<String?> handleSignInEmail(String email, String password) async {
      try {
        final result = await _firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);
        await storeUserDetails(email, null);
        print(result);
        return null;  // No error message means success
      } on auth.FirebaseAuthException catch (e) {
        print('FirebaseAuthException: ${e.message}, Code: ${e.code}');  // Log detailed error message and code
        if (e.code == 'invalid-credential') {
          return 'Invalid credentials.';
        } else {
          return 'An error occurred. Please try again.';
        }
      } catch (e) {
        print('Exception: ${e.toString()}');  // Log unexpected error message
        return 'An unexpected error occurred.';
      }
    }

  Future<void> storeUserDetails(String email, String? username ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);
    if (username != null){
    await prefs.setString('username', username);}
  }
    Future<String?> handleSignUp(String email, String password , String username) async {
    try {
      final result = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      await storeUserDetails(email, username);

      print(result);

      return null;  // No error message means success
    } on auth.FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return 'The email is already in use by another account.';
      } else if (e.code == 'invalid-email') {
        return 'The email address is not valid.';
      } else if (e.code == 'weak-password') {
        return 'The password is too weak.';
      } else {
        return 'An error occurred. Please try again.';
      }
    } catch (e) {
      return 'An unexpected error occurred.';
    }

  }

  Future<void> logout() async {
    return await _firebaseAuth.signOut();
  }
}