import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class MaterialLocalizationRwDelegate extends LocalizationsDelegate<MaterialLocalizations> {
  /// Here list supported country and language codes
  @override
  bool isSupported(Locale locale) => locale.languageCode == "rw";
  /// Here create an instance of your [MaterialLocalizations] subclass
  @override
  Future<MaterialLocalizations> load(Locale locale) async => MaterialLocalizationRw();
  @override
  bool shouldReload(_) => false;
}

class MaterialLocalizationRw extends DefaultMaterialLocalizations {
  // alt-enter on intellij and implement many overrides (somthing like 57)

}