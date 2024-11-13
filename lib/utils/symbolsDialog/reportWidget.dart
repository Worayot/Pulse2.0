import 'package:flutter/material.dart';
import 'package:pulse/utils/DateNavigation.dart';
import 'package:pulse/utils/swipableTable.dart';

class ReportWidget extends StatelessWidget {
  final double tableHeight;
  const ReportWidget({super.key, required this.tableHeight});

  @override
  Widget build(BuildContext context) {
    // double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const DateNavigation(),
          const SizedBox(height: 20),
          SizedBox(height: tableHeight, child: const SwipableTable())
        ],
      ),
    );
  }
}
