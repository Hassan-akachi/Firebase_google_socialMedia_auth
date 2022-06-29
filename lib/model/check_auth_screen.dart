import 'package:dummy_trade/screens/welcome/custom_splash.dart';
import 'package:dummy_trade/screens/auth_screen/verification_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthCheck extends StatelessWidget {
  static const routeName = "AuthCheck";
  const AuthCheck({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final stream =FirebaseAuth.instance.authStateChanges();
    return Scaffold(
      body: StreamBuilder<User?>(
        stream:stream,
        builder: (context,snapshot) {
        if(
        snapshot.connectionState == ConnectionState.waiting
        ){return const Center(child: CircularProgressIndicator(),);}
        else if(snapshot.hasData){
          return const VerificationScreen();

        }else if(snapshot.hasError){
          return Expanded(child: Container(color: Colors.red,));

        }else{
          return const SplashWidget();
        }
        },),
    );
  }
}
