import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:app/shared/getit/getit.dart';
import 'package:app/shared_preferences_provider.dart';
import 'package:app/theme/dark/dark_theme.dart';
import 'package:app/theme/light/light_theme.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:app/shared/routes/router.dart' as router;
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.getInstance().then((instance) async {
    WidgetsFlutterBinding.ensureInitialized();

    final initializer = MyAppInitializer();
    final prefs = await initializer.initialize();
    runApp(MyApp(prefs));
  });
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;

  const MyApp(this.prefs, {super.key});

  @override
  Widget build(BuildContext context) {
    GetItRegister.register();

    final botToastBuilder = BotToastInit();

    return ThemeProvider(
      initTheme: prefs.getBool("darkTheme") ?? false ? darkTheme : lightTheme,
      child: MaterialApp(
        title: 'Pokedex',
        builder: (context, child) {
          child = botToastBuilder(context, child);
          return child;
        },
        theme: lightTheme,
        navigatorObservers: [BotToastNavigatorObserver()],
        debugShowCheckedModeBanner: false,
        routes: router.Router.getRoutes(context),
        initialRoute: "/splash",
      ),
    );
  }
}
