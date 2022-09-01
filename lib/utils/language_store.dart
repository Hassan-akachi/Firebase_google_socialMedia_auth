


import 'dart:ui';

import 'package:shared_preferences/shared_preferences.dart';

const String LAGUAGE_CODE = 'languageCode';

//languages code
const String ENGLISH = 'en';
const String FRENCH = 'fr';
const String ARABIC = 'ar';
const String KINYARWANDA = 'rw';
const String SWAHILLI ="sw";

Future<Locale> storeLocale(String languageCode) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  await _prefs.setString(LAGUAGE_CODE, languageCode);
  return _locale(languageCode);
}

Future<Locale> getLocale() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  String languageCode = _prefs.getString(LAGUAGE_CODE) ?? ENGLISH;
  return _locale(languageCode);
}

Locale _locale(String languageCode) {
  switch (languageCode) {
    case ENGLISH:
      return const Locale(ENGLISH, '');
    case FRENCH:
      return const Locale(FRENCH, "");
    case ARABIC:
      return const Locale(ARABIC, "");
    case KINYARWANDA:
      return const Locale(KINYARWANDA, "");
    case SWAHILLI:
      return const Locale(SWAHILLI, "");
    default:
      return const Locale(ENGLISH, '');
  }
}