import 'package:dummy_trade/model/check_auth_screen.dart';
import 'package:dummy_trade/model/utils.dart';
import 'package:dummy_trade/provider/auth_provider.dart';
import 'package:dummy_trade/screens/auth_screen/forget_password_screen.dart';
import 'package:dummy_trade/screens/auth_screen/otp_screen.dart';
import 'package:dummy_trade/screens/auth_screen/verification_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/welcome/custom_splash.dart';
import 'screens/home_screen.dart';
import 'screens/auth_screen/sign_in_screen.dart';
import 'screens/auth_screen/sign_up_screen.dart';
import 'screens/auth_screen/welcome_screen.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<AuthProvider>(
        create: (context) => AuthProvider(),
      ),
    ],
  child: const DummyTrade()));
}

final navigatorKey =GlobalKey<NavigatorState >();

class DummyTrade extends StatelessWidget {
  const DummyTrade({Key? key}) : super(key: key);


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Dummy Trade',
      scaffoldMessengerKey: Utils.messengerKey,
      navigatorKey: navigatorKey,
      home: const AuthCheck(),
      routes: {
        SplashWidget.routeName :(context)=>const SplashWidget(),
        AuthCheck.routeName :(context)=>const AuthCheck(),
        WelcomeScreen.routeName : (context) => const WelcomeScreen(),
        SignInScreen.routesName :(context)=>  const SignInScreen(),
        SignUpScreen.routeName :(context)=>const SignUpScreen(),
        HomeScreen.routeName :(context)=>const HomeScreen(),
        ForgetPasswordScreen.routeName :(context)=>const ForgetPasswordScreen(),
        VerificationScreen.routeName :(context)=>const VerificationScreen(),
        OtpScreen.routeName : (context)=> const OtpScreen()
      }
    );
  }
}

