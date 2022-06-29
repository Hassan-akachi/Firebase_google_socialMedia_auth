import 'package:dummy_trade/constants/string.dart';
import 'package:dummy_trade/model/auth_page.dart';
import 'package:dummy_trade/model/check_auth_screen.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:splashscreen/splashscreen.dart';

import '../auth_screen/sign_in_screen.dart';



class SplashWidget extends StatelessWidget{
  static const routeName= "Splash_widget";
  const SplashWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double size =(MediaQuery.of(context).size.height*0.3);
    return  Center(
      child: SplashScreen(
        backgroundColor:const Color.fromRGBO(0, 148, 255, 1) ,
        seconds: 14,
        navigateAfterSeconds: const AuthPage(),
        image:Image.asset("images/splash.png",alignment: Alignment.bottomCenter,) ,
        loadingText: const Text('Let\' s have fun',style: TextStyle(color: Colors.white),),
        photoSize: 200.0,
          // seconds: 5,
          // navigateAfterSeconds: const AuthPage(),
          // title: const Text('Dummy-Trade',
          //   style:TextStyle(
          //       fontWeight: FontWeight.bold,
          //       fontSize: 20.0
          //   ),),
          // image:  Image.asset("images/splash_image.png"),
          // backgroundColor: Colors.white,
          // styleTextUnderTheLoader: const TextStyle(),
          // photoSize: size,
          // // onClick: ()=>print("Flutter Egypt"),
          // loaderColor: Colors.blue

      ),
    );
  }
}
