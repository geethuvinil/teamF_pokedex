import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Languages{
  final int? id;
  final String? name;
  final String? flag;
  final String? languageCode;


  Languages({ this.id,  this.name,  this.flag,  this.languageCode});
  
  static List<Languages> languageList (){
return<Languages>[
Languages(id: 1,flag: '🏴󠁧󠁢󠁥󠁮󠁧󠁿',name: 'English',languageCode: 'en'),
Languages(id: 2,flag: '🇮🇳',name: 'हिंदी',languageCode: 'hi'),
Languages(id: 3,flag: '🇦🇪',name: 'عربي',languageCode: 'ar'),
];
  }
  }