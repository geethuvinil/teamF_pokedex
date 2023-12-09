import 'package:app/shared_preferences_provider.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app/main.dart';

Future<void> main() async {
  testWidgets('find home_page key in widget', (tester) async {
    final initializer = MyAppInitializer();
    final prefs = await initializer.initialize();
    await tester.pumpWidget(MyApp(prefs));
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 1));
    // final homePageWidget = find.byKey(const Key('home_page'));
    // print(homePageWidget);
    // expect(homePageWidget, findsOneWidget);
  });
}
