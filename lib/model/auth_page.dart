import 'package:dummy_trade/screens/auth_screen/sign_in_screen.dart';
import 'package:dummy_trade/screens/auth_screen/welcome_screen.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin =true;
  @override

  Widget build(BuildContext context) {
    void toggle(){
      setState((){
        isLogin =!isLogin;
      });
    }
    return isLogin ? SignInScreen(onClickedSignUp: toggle,):
    WelcomeScreen(onClickedSignUp: toggle,);
  }

}
