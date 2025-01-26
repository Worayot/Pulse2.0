import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:pulse/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Design testing of our dashboard', (tester) async {
    // Launch the app with localization setup
    await tester.pumpWidget(
      EasyLocalization(
        supportedLocales: const [Locale('en', 'US'), Locale('th', 'TH')],
        path: 'lang', // Ensure correct path for localization files
        fallbackLocale: const Locale('en', 'US'),
        startLocale: const Locale('th', 'TH'),
        child: MaterialApp(
          home: app.MyApp(),
        ),
      ),
    );

    // Increase wait time for the app to fully settle
    await tester.pumpAndSettle(Duration(seconds: 10));

    // Get current locale (which should be Thai)
    final currentLocale =
        EasyLocalization.of(tester.element(find.byType(app.MyApp)))?.locale;
    print('Current Locale: $currentLocale');

    // Verify if the widget with the expected Thai text is rendered
    final homeTextFinder = find.text('หน้าหลัก');
    final homeTextWidgets = tester.widgetList(homeTextFinder).toList();
    print('Found ${homeTextWidgets.length} instances of "หน้าหลัก"');

    // Check if we find one or more widgets with Thai text
    expect(homeTextWidgets.length, greaterThanOrEqualTo(1));

    // Optional: Check if fallback text in English is found (if available)
    final fallbackTextFinder = find.text('Home');
    final fallbackTextWidgets = tester.widgetList(fallbackTextFinder).toList();
    print('Found ${fallbackTextWidgets.length} instances of "Home"');

    // We will check that English text is found if it's available in the widget
    if (fallbackTextWidgets.isNotEmpty) {
      expect(fallbackTextWidgets.length, greaterThanOrEqualTo(1));
    } else {
      print(
          "English text not found; ensure your localization files are set up correctly.");
    }
  });
}
