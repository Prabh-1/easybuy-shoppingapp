// signin_controller.dart
import 'package:easybuy/modules/Home/View/Homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../OtpPage.dart';

class SignInController extends GetxController {
  final RxBool rememberPassword = true.obs;
  final TextEditingController phoneController = TextEditingController();


  void signIn(String email, String password) {
    // Add your sign-in logic here
    if (email.isNotEmpty && password.isNotEmpty) {
      // Perform sign-in actions
      print('Signing in with email: $email and password: $password');
    } else {
      // Show error messages if fields are empty
      print('Email and password cannot be empty');
    }
  }


  sendcode() async {
    print(phoneController.text);
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: '+91' + phoneController.text,
          verificationCompleted: (PhoneAuthCredential credential) {},
          verificationFailed: (FirebaseAuthException e) {
            Get.snackbar('Error Occured ', e.code);
          },
          codeSent: (String vid, int? token) {
            Get.to(OtpPage(vid: vid,),);
          },
          codeAutoRetrievalTimeout: (vid) {}
      );
    } on FirebaseAuthException catch (e) {
      Get.snackbar('error occured', e.toString());
    }
    catch (e) {
      Get.snackbar('error occured', e.toString());
    }
  }
  Future<void> storeUserDetails(String method, String? email, String? displayName, String? phoneNumber) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('signup_method', method);
    if (email != null) {
      await prefs.setString('email', email);// Store phone number if available
    }

    if (phoneNumber != null) {
      await prefs.setString('phone_number', phoneNumber); // Store phone number if available
    }
    if (displayName != null) {
      await prefs.setString('username', displayName);
    }
  }


  Future<void> signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    try {
      final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );

        var result = await FirebaseAuth.instance.signInWithCredential(credential);
        final User? user = result.user;

        if (user != null) {
          final String email = user.email ?? 'No email available';
          final String displayName = user.displayName ?? 'No display name available';
          await storeUserDetails('google', email, displayName, null);
          print('Email: $email');
          print('Display Name: $displayName');
          Get.to(() => HomePage());
        } else {
          Get.snackbar('Error', 'Failed to retrieve user details');
        }
      } else {
        // User canceled Google sign-in
        Get.snackbar('Error', 'Google sign-in canceled by user');
      }
    } catch (e) {
      // Handle Google sign-in errors
      Get.snackbar('Error', 'Failed to sign in with Google: $e');
    }
  }

  String? validateEmail(String? value) {
    if (value?.isEmpty ?? true) {
      return 'Enter an email!';
    } else if (!RegExp(r"^[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$").hasMatch(value!)) {
      return 'Enter a valid email!';
    }
    return null;
  }



  String? validatePassword(String? value) {
    if (value?.isEmpty ?? true) {
      return 'Enter a password!';
    }

    if (_isLengthInvalid(value!)) {
      return 'Password should be between 6 and 15 characters';
    }

    if (!_containsCapitalLetter(value)) {
      return 'Password must contain at least one capital letter';
    }

    if (!_containsSpecialCharacter(value)) {
      return 'Password must contain a special character';
    }

    if (!_containsNumber(value)) {
      return 'Password must contain a number';
    }

    return null;
  }

  bool _isLengthInvalid(String value) {
    return value.length < 6 || value.length > 15;
  }

  bool _containsCapitalLetter(String value) {
    return RegExp(r'[A-Z]').hasMatch(value);
  }

  bool _containsSpecialCharacter(String value) {
    return RegExp(r'[!@#$%^&*()_+{}|:;<>,.?/~]').hasMatch(value);
  }

  bool _containsNumber(String value) {
    return RegExp(r'[0-9]').hasMatch(value);
  }
}


