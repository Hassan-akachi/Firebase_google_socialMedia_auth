import 'package:dummy_trade/l10n/L10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class LocaleProvider  extends ChangeNotifier {

   Locale? _locale;

  Locale? get locale => _locale;

  void setLocale(Locale locale){
    if(!L10n.all.contains(locale)) return;
    _locale =locale;
    notifyListeners();

  }
  void clearLocale() {
    _locale = null;
    notifyListeners();
  }
}
