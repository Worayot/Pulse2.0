import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GenderBarChartDialog extends StatelessWidget {
  final String csvFilePath;

  const GenderBarChartDialog({Key? key, required this.csvFilePath})
      : super(key: key);

  Future<Map<String, int>> loadAndProcessCSV() async {
    final data = await rootBundle.loadString(csvFilePath);
    final List<List<dynamic>> csvTable = CsvToListConverter().convert(data);

    // Assuming gender is in the second column (index 1)
    Map<String, int> genderCount = {
      'Male': 0,
      'Female': 0,
    };

    for (var row in csvTable.skip(1)) {
      // Skip the header row
      String gender = row[1].toString().trim();
      if (gender == 'Male' || gender == 'Female') {
        genderCount[gender] = (genderCount[gender] ?? 0) + 1;
      }
    }

    return genderCount;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, int>>(
      future: loadAndProcessCSV(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return AlertDialog(
            content: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return AlertDialog(
            content: Text("Error loading data"),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return AlertDialog(
            content: Text("No data found"),
          );
        } else {
          final genderCount = snapshot.data!;
          return AlertDialog(
            title: Row(
              children: [
                const Text('จำแนกด้วยเพศ'),
                const Spacer(),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const Icon(FontAwesomeIcons.xmark),
                ),
              ],
            ),
            contentPadding: EdgeInsets.all(20),
            content: Container(
              width: 600,
              height: 400,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: (genderCount.values.reduce((a, b) => a > b ? a : b))
                          .toDouble() +
                      40,
                  barGroups: [
                    BarChartGroupData(
                      x: 0,
                      barRods: [
                        BarChartRodData(
                          toY:
                              genderCount['Male']!.toDouble(), // Added toY here
                          color: Colors.blue,
                          width: 40,
                          borderRadius: BorderRadius.zero, // No border radius
                        ),
                      ],
                      showingTooltipIndicators: [0],
                    ),
                    BarChartGroupData(
                      x: 1,
                      barRods: [
                        BarChartRodData(
                          toY: genderCount['Female']!
                              .toDouble(), // Added toY here
                          color: Colors.pink,
                          width: 40,
                          borderRadius: BorderRadius.zero, // No border radius
                        ),
                      ],
                      showingTooltipIndicators: [0],
                    ),
                  ],
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (double value, TitleMeta meta) {
                          switch (value.toInt()) {
                            case 0:
                              return Text('Male');
                            case 1:
                              return Text('Female');
                            default:
                              return Text('');
                          }
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 10, // Set interval to 50
                        reservedSize:
                            35, // Set width for the Y-axis labels (this controls the width of the Y-axis)
                        getTitlesWidget: (value, meta) {
                          return Text(
                              value.toString()); // Display values on Y-axis
                        },
                      ),
                    ),
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
