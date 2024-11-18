// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:integration_test/integration_test.dart';
// import 'package:pulse/main.dart' as app;
// import 'package:pulse/temp/dashboard.dart';

// void main() {
//   IntegrationTestWidgetsFlutterBinding.ensureInitialized();

//   testWidgets('Design testing of our dashboard', (tester) async {
//     // Launch the app
//     app.main();
//     await tester.pumpAndSettle();

//     expect(find.text('Dashboard'), findsAny);
//     expect(find.text('จัดกลุ่มตามอายุ'), findsAny);
//     expect(find.text('เฝ้าระวังเป็นพิเศษ'), findsAny);
//     expect(find.text('จัดกลุ่มตามเพศ'), findsAny);
//     expect(find.text('จัดกลุ่มตามหอผู้ป่วย'), findsAny);
//     final dashboardCards = find.byType(DashboardCard);
//     expect(dashboardCards, findsNWidgets(4));

//     final topLeftDashboardCardFinder = find.byWidgetPredicate((widget) =>
//         widget is InkWell &&
//         widget.child is DashboardCard &&
//         (widget.child as DashboardCard).title == "จัดกลุ่มตามอายุ");
//     final dialogSize = tester.getSize(topLeftDashboardCardFinder);
//     expect(dialogSize.height, equals(175.0));

//     final topRightDashboardCardFinder = find.byWidgetPredicate((widget) =>
//         widget is InkWell &&
//         widget.child is DashboardCard &&
//         (widget.child as DashboardCard).title == "เฝ้าระวังเป็นพิเศษ");
//     final topRightSide = tester.getSize(topRightDashboardCardFinder);
//     expect(topRightSide.height, equals(175.0));

//     final bottomRightDashboardCardFinder = find.byWidgetPredicate((widget) =>
//         widget is InkWell &&
//         widget.child is DashboardCard &&
//         (widget.child as DashboardCard).title == "จัดกลุ่มตามหอผู้ป่วย");
//     final bottomRightSide = tester.getSize(bottomRightDashboardCardFinder);
//     expect(bottomRightSide.height, equals(175.0));
//     final bottomLeftDashboardCardFinder = find.byWidgetPredicate((widget) =>
//         widget is InkWell &&
//         widget.child is DashboardCard &&
//         (widget.child as DashboardCard).title == "จัดกลุ่มตามเพศ");
//     final bottomLeftSide = tester.getSize(bottomLeftDashboardCardFinder);
//     expect(bottomLeftSide.height, equals(175.0));
//   });
// }
