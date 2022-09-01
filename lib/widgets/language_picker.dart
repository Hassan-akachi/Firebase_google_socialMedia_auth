import 'package:dummy_trade/l10n/L10n.dart';
import 'package:dummy_trade/provider/locale_provider.dart';
import 'package:dummy_trade/utils/language_store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LangugaePicker extends StatelessWidget {
  const LangugaePicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocaleProvider>(context,);
    final locale = provider.locale ?? const Locale('en');
    return DropdownButtonHideUnderline(
        child: DropdownButton(
      value: locale,
      icon: const Icon(Icons.language,color:Colors.white,),
      items: L10n.all.map((locale) {
        final flag = L10n.getFlag(locale.languageCode);
        return DropdownMenuItem(
          value: locale,
          onTap: ()async {
            //await storeLocale(locale.languageCode);
            final provider =
                Provider.of<LocaleProvider>(context,listen: false );
            provider.setLocale(locale);
          },
          child: Center(
            child: Text(
              flag,
              style: const TextStyle(fontSize: 20),
            ),
          ),
        );
      }).toList(),
      onChanged: (_) {},
    ));
  }
}
