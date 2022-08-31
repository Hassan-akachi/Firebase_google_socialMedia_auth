import 'package:dummy_trade/main.dart';
import 'package:dummy_trade/model/check_auth_screen.dart';
import 'package:dummy_trade/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../model/utils.dart';



class AuthProvider extends ChangeNotifier{
 final googleSignIn= GoogleSignIn();

 GoogleSignInAccount? _user ;

 GoogleSignInAccount  get user => _user!;

 Future googleLogIn()async{
  try{
   final googleUser = await googleSignIn.signIn();
   if(googleUser == null) return ;
   _user =googleUser ;

   final googleAuth =await googleUser.authentication;

   final credential= GoogleAuthProvider.credential(
     accessToken:googleAuth.accessToken,
     idToken:  googleAuth.idToken
   );
   await FirebaseAuth.instance.signInWithCredential(credential);
   navigatorKey.currentState!.pushReplacementNamed(HomeScreen.routeName);
   notifyListeners();
  }
  catch(e){
    Utils.showSnackBar(e.toString());
  }
}

Future logout()async{
  await googleSignIn.disconnect();
  FirebaseAuth.instance.signOut();
  navigatorKey.currentState!.popAndPushNamed(AuthCheck.routeName);
}

//register with phone
 final _auth= FirebaseAuth.instance;
 String? verificationCode;

 Future createUserWithPhone(phone)async{
  await _auth.verifyPhoneNumber(
      phoneNumber: phone,
      timeout: const Duration(seconds: 30),
      verificationCompleted: (PhoneAuthCredential credential)async{
      await _auth.signInWithCredential(credential).then((value) async{
       if (value.user != null){
         print("user logged in");
         navigatorKey.currentState!.popUntil((route)=>route.isFirst);
       }
      });
      },
      verificationFailed: (FirebaseAuthException exception){
       print(exception);
      },
      codeSent: (String verificationID,int? resendToken){
        verificationCode =verificationID;
        notifyListeners();
      },
      codeAutoRetrievalTimeout:(String verificationID){
       verificationCode= verificationID;
       notifyListeners();
      });
  notifyListeners();
 }

}