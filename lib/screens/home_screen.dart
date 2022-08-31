import 'package:dummy_trade/model/auth_services.dart';
import 'package:dummy_trade/provider/auth_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../main.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = "Home-Screen";

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              navigatorKey.currentState!.popUntil((route) => route.isFirst);
            },
            child: Text(AppLocalizations.of(context)!.signup,style: TextStyle(fontSize: 20,color: Colors.white)),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [CircleAvatar(radius: 100,
            backgroundImage:  user.photoURL != null ? NetworkImage(user.photoURL.toString())as ImageProvider :const AssetImage("images/makeup3.png") ,
          ),
            const SizedBox(height: 20,),
            Text(
              "${user.displayName}",
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20),
            ),
            Text(
              "${user.email}",
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20),
            ),
            TextButton(
                style: TextButton.styleFrom(backgroundColor: Colors.blue),
                onPressed: () {
                  AuthService().signout();
                  Provider.of<AuthProvider>(context,listen: false).logout();
                  navigatorKey.currentState!.popUntil((route) => route.isFirst);
                },
                child:  Text(
                  AppLocalizations.of(context)!.signout ,
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ))
          ],
        ),
      ),
    );
  }
}
