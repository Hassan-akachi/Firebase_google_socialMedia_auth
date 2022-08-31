import 'package:dummy_trade/provider/auth_provider.dart';
import 'package:dummy_trade/screens/auth_screen/sign_up_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../widgets/sign_button.dart';

class WelcomeScreen extends StatelessWidget {
  static const routeName = "Welcome-Screen";

  final GestureTapCallback? onClickedSignUp;

  const WelcomeScreen({Key? key, this.onClickedSignUp}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,
      body:Padding(padding:const EdgeInsets.symmetric(horizontal: 30,),
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(width: 100,height:200,child: Image.asset("images/app_store.jpeg")),
                SignButton(
                  buttoncolor: Colors.blue,
                  textcolor: Colors.white,
                  buttonText: "${AppLocalizations.of(context)!.signup} ${AppLocalizations.of(context)!.email}",
                  onPressed: () {
                    Navigator.pushNamed(context, SignUpScreen.routeName);

                  },
                  iconData: Icons.mail,
                ),
          const SizedBox(
            height: 20,
          ),
           Padding(
             padding: const EdgeInsets.symmetric(horizontal: 30),
             child: RichText(text: TextSpan(text: AppLocalizations.of(context)!.donthaveanaccount,
               style: const TextStyle(color: Colors.black ,fontSize: 20),
               children: [
                 TextSpan(recognizer: TapGestureRecognizer()
                 ..onTap= onClickedSignUp,
                 text: AppLocalizations.of(context)!.signup,
                 style:const TextStyle(
                   decoration: TextDecoration.underline,
                   color: Colors.blue
                 ))
               ]
             )),
           )
        ],
    ),
      ),);
  }
}
