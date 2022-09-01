import 'dart:async';

import 'package:dummy_trade/l10n/L10n.dart';
import 'package:dummy_trade/utils/language_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LocaleProvider  extends ChangeNotifier {

   Locale? _locale;
   static const String LANGUAGE_CODE ="languageCode";

  Locale? get locale => _locale;

  Future<void> setLocale(Locale locale) async{
    if(!L10n.all.contains(locale)) return;
    _locale =locale;
    storeLocale(locale.languageCode);
    // storelocal(locale.languageCode);
    notifyListeners();

  }

  // Future storelocal(String languageCode) async{
  //   SharedPreferences _prefs= await SharedPreferences.getInstance();
  //   await _prefs.setString(LANGUAGE_CODE, languageCode);
  //   //print("language set!!!!!");
  //   notifyListeners();
  // }
  //
  // Future<String> getLocal()async {
  //   SharedPreferences _prefs = await SharedPreferences.getInstance();
  //   String languageCode = _prefs.getString(LANGUAGE_CODE) ?? "en";
  //   final flag = L10n.getFlag(languageCode);
  //   return flag;
  // }


  void clearLocale() {
    _locale = null;
    notifyListeners();
  }
}
