import 'package:dummy_trade/screens/welcome/custom_splash.dart';
import 'package:dummy_trade/screens/auth_screen/sign_in_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import '../screens/home_screen.dart';
import 'utils.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;
  final user = FirebaseAuth.instance.currentUser;


  bool isLogin = true;

  Future signup(context, email, password,name,formKey) async {
    //validation
    final isValid = formKey.currentState!.validate();
    if(!isValid)return;

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
    try {
      var newUser = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = newUser.user;
      user?.updateDisplayName(name); //added this line
      if (newUser != null) {
        // navigatorKey.currentState!.popUntil((route)=>route.isFirst);

      }
    }on FirebaseAuthException catch (e) {
      print(e);
       //show snackbar if there is any error
      Utils.showSnackBar(e.message);
      Navigator.pop(context);
    }
  }

  Future signin(email, password, context,formKey) async {
    final isValid = formKey.currentState!.validate();
    if(!isValid)return;
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
    try {
      var newUser = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (newUser != null) {
        navigatorKey.currentState!.pushReplacementNamed(HomeScreen.routeName);
      }
    }on FirebaseAuthException catch (e) {
      print(e);
      Utils.showSnackBar(e.message);
      Navigator.pop(context);
    }
  }
  Future passwordReset(email,context)async{
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
    try {
      await _auth.sendPasswordResetEmail(email: email);
      Utils.showSnackBar("password sent");
      navigatorKey.currentState!.popUntil((route)=>route.isFirst);
    }on FirebaseAuthException catch(e){
      print(e);
      Utils.showSnackBar(e.message);

    }
  }







  Future signout() async {
    return _auth.signOut();

  }
}
