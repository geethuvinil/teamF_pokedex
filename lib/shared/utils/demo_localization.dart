import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DemoLocalization{
  final Locale? loc;

  DemoLocalization(this.loc);
  static DemoLocalization of(BuildContext context){
    return Localizations.of(context, DemoLocalization);
  }

  Map<String, String>? localizedValues; 

  Future load() async{
    String jsonStringValues = await rootBundle.loadString('lib/lang/${loc?.languageCode}.json');

Map<String,dynamic> mappedJson =  json.decode(jsonStringValues);

localizedValues = mappedJson.map((key, value) => MapEntry(key, value.toString()));

  }

  String? getTransalatedValue (String key){
    return localizedValues?[key];
  }

  static  const LocalizationsDelegate<DemoLocalization> delegate = DemoLocalizationDelegate();
}



class DemoLocalizationDelegate extends LocalizationsDelegate<DemoLocalization>{

  const DemoLocalizationDelegate();
  @override
  bool isSupported(Locale locale) {
  return ['en','ar','hi'].contains(locale.languageCode);
  }

  @override
  Future<DemoLocalization> load(Locale locale) async {
DemoLocalization localization =  new DemoLocalization(locale);
await localization.load();
return localization;
  }

  @override
 bool shouldReload(DemoLocalizationDelegate old) => false;

}