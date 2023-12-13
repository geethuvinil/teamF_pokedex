import 'package:app/modules/login/login_page.dart';
import 'package:app/spalsh_screen.dart';
import 'package:flutter/material.dart';
import 'package:app/modules/home/home_page.dart';
import 'package:app/modules/items/items_page.dart';

abstract class Router {
 // static String home = "/";
  static String items = "/items";
  static String login = "/login";
  static String splash = "/splash";

  static Map<String, WidgetBuilder> getRoutes(context) {
    return {
      login: (context) => LoginPage(),
      //home: (context) => HomePage(),
      items: (context) => ItemsPage(),
      splash:(context) => SplashScreen()
    };
  }
}
