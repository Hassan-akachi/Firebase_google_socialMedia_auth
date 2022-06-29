import 'package:dummy_trade/main.dart';
import 'package:dummy_trade/model/utils.dart';
import 'package:dummy_trade/provider/auth_provider.dart';
import 'package:dummy_trade/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class OtpScreen extends StatelessWidget{
  static const routeName ="Otp-Screen";

  final String? phoneNumber;

  const OtpScreen({Key? key, this.phoneNumber}) : super(key: key);


  // @override
  // void initState() {
  //   super.initState();
  //   Provider.of<AuthProvider>(context).createUserWithPhone(widget.phoneNumber);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text(
              "A Verification Has Been sent to this Number\n $phoneNumber",
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
            ),
            const SizedBox(
              height: 20,
            ),
            Pinput(
              length: 6,
              validator: (value) => value != null && value.length < 6
                  ? "Enter min. 6 characters"
                  : null,
              pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
              showCursor: true,
              onCompleted: (pin) async {
                try{
                print(pin);
                await FirebaseAuth.instance.signInWithCredential(
                    PhoneAuthProvider.credential(
                        verificationId:
                            Provider.of<AuthProvider>(context,listen: false).verificationCode!,
                        smsCode: pin)).then((value)async {
                          if(value.user != null){
                            print("pass to home");
                            navigatorKey.currentState!.pushReplacementNamed(HomeScreen.routeName);
                          }
                });}catch(e){
                  FocusScope.of(context).unfocus();
                  Utils.showSnackBar("inValid otp $e");
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
