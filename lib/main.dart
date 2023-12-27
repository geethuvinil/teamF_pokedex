import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:app/shared/getit/getit.dart';
import 'package:app/shared/utils/demo_localization.dart';
import 'package:app/shared_preferences_provider.dart';
import 'package:app/theme/dark/dark_theme.dart';
import 'package:app/theme/light/light_theme.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:app/shared/routes/router.dart' as router;
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';



void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.getInstance().then((instance) async {
    WidgetsFlutterBinding.ensureInitialized();

    final initializer = MyAppInitializer();
    final prefs = await initializer.initialize();
    runApp(MyApp(prefs));
  });
}

class MyApp extends StatefulWidget {

  static void setLocale(BuildContext context, Locale locale){
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(locale); 
  }
  final SharedPreferences prefs;

  const MyApp(this.prefs, {super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

Locale? _locale;

void setLocale(Locale locale){
  setState(() {
    _locale = locale;
  });
}

  @override
  Widget build(BuildContext context) {
    GetItRegister.register();

    final botToastBuilder = BotToastInit();

    return ThemeProvider(
      initTheme: widget.prefs.getBool("darkTheme") ?? false ? darkTheme : lightTheme,
      child: MaterialApp(
        title: 'Pokedex',
        builder: (context, child) {
          child = botToastBuilder(context, child);
          return child;
        },
        locale:_locale ,
        theme: lightTheme,
        navigatorObservers: [BotToastNavigatorObserver()],
        debugShowCheckedModeBanner: false,
        routes: router.Router.getRoutes(context),
        initialRoute: "/splash",
        localizationsDelegates: [
          //AppLocalizations.delegate,
          DemoLocalization.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate
        ],

        localeResolutionCallback: (deviceLocale, supportedLocales) {
          for(var locale in supportedLocales){
            if(locale.languageCode == deviceLocale?.languageCode &&
             locale.countryCode ==deviceLocale?.countryCode){
              return deviceLocale;
            }
          }

          return supportedLocales.first;
        },
        //locale: Locale('en'),
        supportedLocales:[
          Locale('en','US'),
             Locale('hi','IN'),
                Locale('ar','UM'),
        ]
      ),
    );
  }
}
