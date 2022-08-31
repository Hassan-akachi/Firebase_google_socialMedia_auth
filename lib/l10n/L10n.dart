


import 'package:flutter/material.dart';

class L10n{
    static final all =[
      const Locale("en"),//english
      const Locale("ar"),//arabic
      const Locale("fr"),//french
      const Locale("sw"),//swahili
      const Locale("rw"),//	kinrwanda
    ];

    static String getFlag(String code){
      switch(code){
        case "ar":
          return "🇦🇪 عربى";
        case "fr":
          return "🇫🇷 Français";
        case "sw":
          return "🇰🇪 kiswahili";
        case "rw":
          return "🇷🇼 kinyarwanda";
        case "en":
        default:
          return "🇬🇧 English";
      }
    }
}