import 'package:easybuy/modules/Home/View/Homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'controller/signin_controller.dart';

class OtpPage extends StatefulWidget {
  final String vid;
  const OtpPage({super.key, required this.vid});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final SignInController controller = Get.find();
  var code = '';
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 50.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'OTP Verification',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Enter the OTP sent to your mobile number',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              textcode(),
              SizedBox(height: 40),
              button(),
              if (isLoading) CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }

  Widget button() {
    return ElevatedButton(
      onPressed: isLoading ? null : verifyOtp,
      child: Text('Verify'),
    );
  }

  Widget textcode() {
    return Pinput(
      length: 6,
      onChanged: (value) {
        setState(() {
          code = value;
        });
      },
      showCursor: true,
      onCompleted: (value) {
        setState(() {
          code = value;
        });
      },
    );
  }

  Future<void> verifyOtp() async {
    setState(() {
      isLoading = true;
    });

    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: widget.vid,
        smsCode: code,
      );

      // Sign in using the credential
      UserCredential userCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);

      if (userCredential.user != null) {
        Get.snackbar('Success', 'OTP verified successfully!');
        await controller.storeUserDetails('phone', null, null, userCredential.user!.phoneNumber);

        Get.to(HomePage());
      } else {
        Get.snackbar('Error', 'Failed to verify OTP.');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to verify OTP: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}
