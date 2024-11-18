// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:integration_test/integration_test.dart';
// import 'package:pulse/main.dart' as app;
// import 'package:pulse/temp/dashboard.dart';

// void main() {
//   IntegrationTestWidgetsFlutterBinding.ensureInitialized();

//   testWidgets('Test access point of our dashboard', (tester) async {
//     // Launch the app
//     app.main();
//     await tester.pumpAndSettle(); // Wait for the app to settle

//     // Verify the text on the first page
//     expect(find.text('Dashboard'), findsAny);
//     expect(find.text('จัดกลุ่มตามอายุ'), findsAny);
//     expect(find.text('เฝ้าระวังเป็นพิเศษ'), findsAny);
//     expect(find.text('จัดกลุ่มตามเพศ'), findsAny);
//     expect(find.text('จัดกลุ่มตามหอผู้ป่วย'), findsAny);
//     final dashboardCards = find.byType(DashboardCard);

//     // Verify that there are exactly 4 DashboardCard widgets
//     expect(dashboardCards, findsNWidgets(4));

//     final topLeftDashboardCardFinder = find.byWidgetPredicate((widget) =>
//         widget is InkWell &&
//         widget.child is DashboardCard &&
//         (widget.child as DashboardCard).title == "จัดกลุ่มตามอายุ");

//     final xmark = find.byIcon(FontAwesomeIcons.xmark);

//     // Verify that the DashboardCard widget exists
//     expect(topLeftDashboardCardFinder, findsAny);

//     // Tap on the widget
//     await tester.tap(topLeftDashboardCardFinder);
//     await tester.pumpAndSettle(); // Wait for any animations or actions

//     // Verify that an AlertDialog is displayed
//     expect(find.byType(AlertDialog), findsAny);
//     expect(find.text('ข้อมูลเชิงปริมาณของคนไข้เมื่อเทียบเกณฑ์อายุ'), findsAny);

//     // tap back to dashboard
//     await tester.tap(xmark);
//     await tester.pumpAndSettle(); // Wait for any animations or actions

//     final topRightDashboardCardFinder = find.byWidgetPredicate((widget) =>
//         widget is InkWell &&
//         widget.child is DashboardCard &&
//         (widget.child as DashboardCard).title == "เฝ้าระวังเป็นพิเศษ");

//     // Verify that the DashboardCard widget exists
//     expect(topRightDashboardCardFinder, findsOneWidget);

//     // Tap on the widget
//     await tester.tap(topRightDashboardCardFinder);
//     await tester.pumpAndSettle(); // Wait for any animations or actions

//     // Verify that an AlertDialog is displayed
//     expect(find.byType(AlertDialog), findsOneWidget);
//     expect(find.text('ต้องเฝ้าระวังเป็นพิเศษ'), findsOneWidget);

//     expect(xmark, findsOneWidget);

//     // tap back to dashboard
//     await tester.tap(xmark);
//     await tester.pumpAndSettle(); // Wait for any animations or actions

//     final bottomRightDashboardCardFinder = find.byWidgetPredicate((widget) =>
//         widget is InkWell &&
//         widget.child is DashboardCard &&
//         (widget.child as DashboardCard).title == "จัดกลุ่มตามหอผู้ป่วย");

//     // Verify that the DashboardCard widget exists
//     expect(bottomRightDashboardCardFinder, findsOneWidget);

//     // Tap on the widget
//     await tester.tap(bottomRightDashboardCardFinder);
//     await tester.pumpAndSettle(); // Wait for any animations or actions

//     // Verify that an AlertDialog is displayed
//     expect(find.byType(Dialog), findsOneWidget);
//     expect(find.text('จำแนกด้วยหอผู้ป่วย'), findsOneWidget);

//     expect(xmark, findsOneWidget);

//     // tap back to dashboard
//     await tester.tap(xmark);
//     await tester.pumpAndSettle(); // Wait for any animations or actions

//     final bottomLeftDashboardCardFinder = find.byWidgetPredicate((widget) =>
//         widget is InkWell &&
//         widget.child is DashboardCard &&
//         (widget.child as DashboardCard).title == "จัดกลุ่มตามเพศ");

//     // Verify that the DashboardCard widget exists
//     expect(bottomLeftDashboardCardFinder, findsOneWidget);

//     // Tap on the widget
//     await tester.tap(bottomLeftDashboardCardFinder);
//     await tester.pumpAndSettle(); // Wait for any animations or actions

//     // Verify that an AlertDialog is displayed
//     expect(find.byType(AlertDialog), findsOneWidget);
//     expect(find.text('จำแนกด้วยเพศ'), findsOneWidget);

//     // tap back to dashboard
//     await tester.tap(find.byIcon(FontAwesomeIcons.xmark));
//     await tester.pumpAndSettle();
//   });
// }
