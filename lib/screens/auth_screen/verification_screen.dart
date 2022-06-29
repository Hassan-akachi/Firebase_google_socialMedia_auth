import 'dart:async';

import 'package:dummy_trade/model/utils.dart';
import 'package:dummy_trade/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../widgets/sign_button.dart';

class VerificationScreen extends StatefulWidget {
  static const String routeName = "Verification-Screen";

  const VerificationScreen({Key? key}) : super(key: key);

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  bool isEmailVerified = false;
  Timer? timer;
  bool canResendEmail = false;

  @override
  void initState() {
    super.initState();
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    if (!isEmailVerified) {
      sendVerificationEmail();

      timer = Timer.periodic(
          const Duration(seconds: 3), (_) => checkEmailVerified());
    }
  }
//sendVerificationEmail
  Future sendVerificationEmail()async{
    try{
      final user =FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
      setState(() => canResendEmail = false);
      await Future.delayed(const Duration(seconds: 5));
      setState(() => canResendEmail = false);

    }on FirebaseAuthException catch(e){
      print(e);
      Utils.showSnackBar(e.message);
    }
  }
  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (isEmailVerified) timer?.cancel();
  }


  @override
  Widget build(BuildContext context) {
    return isEmailVerified
        ? const HomeScreen ()
        : Scaffold(
            appBar: AppBar(
              title: const Text("verify Email",
                  style: TextStyle(fontSize: 20, color: Colors.white)),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text("A Verification mail as been sent  to your email",
                      style: TextStyle(fontSize: 20)),
                  const SizedBox(
                    height: 20,
                  ),
                  SignButton(
                      buttoncolor: Colors.blue,
                      textcolor: Colors.white,
                      buttonText: "Resend Verification",
                      onPressed: () async {
                        canResendEmail
                            ? sendVerificationEmail()
                            : null;
                      },
                      iconData: Icons.email),
                  ElevatedButton(
                      onPressed: () {
                        FirebaseAuth.instance.signOut();
                      },
                      child: const Text(
                          "cancel",
                          style: TextStyle(fontSize: 20)))
                ],
              ),
            ),
          );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}
