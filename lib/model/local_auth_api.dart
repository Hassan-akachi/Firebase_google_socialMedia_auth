import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class LocalAuthApi {
  static final _localAuth = LocalAuthentication();

  static Future<bool>hasBiometrics()async{
    try{
      final bool canAuthenticateWithBiometrics = await _localAuth.canCheckBiometrics;
      final bool canAuthenticate =
          canAuthenticateWithBiometrics || await _localAuth.isDeviceSupported();
      return canAuthenticate;
    }on PlatformException catch(e) {
      print(e);
      return false;
    }
  }

  static Future<bool> authenticate() async {
    final isAvailable =await hasBiometrics();
    if(!isAvailable)return false;
    try{
      if(!isAvailable)return false;
    return await _localAuth.authenticate(
        localizedReason: "Scan finegrprint to authenticate",
        options:
            const AuthenticationOptions(useErrorDialogs: true, stickyAuth: true));
  }on PlatformException catch(e){
      print(e);
      return false;
    }}
}
