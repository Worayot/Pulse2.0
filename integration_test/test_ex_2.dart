import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:pulse/main.dart' as app;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_localization/easy_localization.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
  });

  testWidgets('Test navigating to add/edit patient notes', (tester) async {
    // Launch the app
    app.main();
    await tester.pumpAndSettle(); // Wait for the app to settle

    // Verify the dashboard
    expect(find.text('Dashboard'), findsOneWidget);

    // Find the "Add/Edit Notes" button
    final addEditNotesButtonFinder =
        find.widgetWithText(ElevatedButton, 'เพิ่ม/แก้ไขหมายเหตุ');
    expect(addEditNotesButtonFinder, findsOneWidget);

    // Tap the button
    await tester.tap(addEditNotesButtonFinder);
    await tester.pumpAndSettle(); // Wait for animations to complete

    // Verify the "Add/Edit Notes" screen
    expect(find.text('เพิ่ม/แก้ไขหมายเหตุคนไข้'), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);

    // Enter text into the TextField
    await tester.enterText(find.byType(TextField), 'หมายเหตุใหม่');
    await tester.pumpAndSettle();

    // Verify the entered text
    expect(find.text('หมายเหตุใหม่'), findsOneWidget);

    // Tap the "Save" button
    final saveButtonFinder = find.widgetWithText(ElevatedButton, 'บันทึก');
    expect(saveButtonFinder, findsOneWidget);

    await tester.tap(saveButtonFinder);
    await tester.pumpAndSettle(); // Wait for save action

    // Verify we're back on the dashboard
    expect(find.text('Dashboard'), findsOneWidget);
    expect(find.text('หมายเหตุใหม่'), findsOneWidget);
  });
}
