import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:pulse/main.dart' as app;
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // Import FontAwesome icons

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Design testing of home page', (tester) async {
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
    await tester.pumpAndSettle();

    // Get current locale (which should be Thai)
    final currentLocale =
        EasyLocalization.of(tester.element(find.byType(app.MyApp)))?.locale;
    print('Current Locale: $currentLocale');

    // Verify if the widget with the expected Thai text "หน้าหลัก" is rendered
    final homeTextFinder = find.text('หน้าหลัก');
    final homeTextWidgets = tester.widgetList(homeTextFinder).toList();
    print('Found ${homeTextWidgets.length} instances of "หน้าหลัก"');

    // Ensure the widget with Thai text is found at least once
    expect(homeTextWidgets.length, greaterThanOrEqualTo(1));

    // Optionally: Check if fallback text "Home" is found in English (if available)
    final fallbackTextFinder = find.text('Home');
    final fallbackTextWidgets = tester.widgetList(fallbackTextFinder).toList();
    print('Found ${fallbackTextWidgets.length} instances of "Home"');

    if (fallbackTextWidgets.isNotEmpty) {
      // Ensure English text is also found if it exists
      expect(fallbackTextWidgets.length, greaterThanOrEqualTo(1));
    } else {
      print(
          "English text not found; ensure your localization files are set up correctly.");
    }

    // Find the first ElevatedButton containing the FontAwesome clock icon
    final clockButtonFinder = find.byIcon(FontAwesomeIcons.solidClock).first;
    expect(clockButtonFinder, findsOneWidget); // Ensure the button is found

    // // Tap the clock button to show the alert dialog
    await tester.tap(clockButtonFinder);
    await tester.pumpAndSettle(); // Wait for the alert dialog to appear

    // // Verify that the AlertDialog is displayed
    final alertDialogFinder = find.byType(AlertDialog);
    expect(alertDialogFinder, findsOneWidget); // Ensure the dialog is found

    // // Find the close button inside the AlertDialog
    final closeButtonIcon = find.byIcon(Icons.close);
    expect(closeButtonIcon, findsOneWidget); // Ensure the close button is found

    // Tap the Xmark icon to close the alert dialog
    await tester.tap(closeButtonIcon);
    await tester.pumpAndSettle(); // Wait for the dialog to close

    // // Verify that the dialog is closed
    expect(alertDialogFinder,
        findsNothing); // Ensure the dialog is no longer present
    //
    final nurseButtonFinder = find.byIcon(FontAwesomeIcons.userNurse).first;
    expect(nurseButtonFinder, findsOneWidget);

    // // Tap the clock button to show the alert dialog
    await tester.tap(clockButtonFinder);
    await tester.pumpAndSettle(); // Wait for the alert dialog to appear
  });
}
