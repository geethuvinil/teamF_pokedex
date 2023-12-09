import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyAppInitializer {
  Future<SharedPreferences> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();
    final prefs = await SharedPreferences.getInstance();
    return prefs;
  }
}
