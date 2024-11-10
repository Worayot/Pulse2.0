import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:csv/csv.dart';

class AgeHistogramDialog extends StatelessWidget {
  final String csvFilePath;

  AgeHistogramDialog({required this.csvFilePath});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<int>>(
      future: _loadData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No data available.'));
        } else {
          List<int> patientAges = snapshot.data!;

          // Create bins for the histogram (age groups)
          List<int> ageBins = List.filled(10, 0); // 10 bins for age groups

          // Categorize patient ages into bins (e.g., 0-9, 10-19, etc.)
          for (int age in patientAges) {
            int binIndex = (age ~/ 10); // Dividing the age into decade ranges
            if (binIndex < 10) {
              ageBins[binIndex]++;
            }
          }

          return AlertDialog(
            title: Row(
              children: [
                const Text('จัดกลุ่มตามอายุ'),
                const Spacer(),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const Icon(FontAwesomeIcons.xmark),
                ),
              ],
            ),
            contentPadding: EdgeInsets.all(10),
            content: Container(
              width: 800,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'ข้อมูลเชิงปริมาณของคนไข้เมื่อเทียบเกณฑ์อายุ',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 400, // Set a fixed height for the chart
                    child: Center(
                      child: BarChart(
                        BarChartData(
                          titlesData: FlTitlesData(
                            show: true,
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: (value, meta) {
                                  return Text(
                                    '${value.toInt()}',
                                    style: const TextStyle(fontSize: 10),
                                  );
                                },
                              ),
                            ),
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: (value, meta) {
                                  int binStart = (value.toInt() * 10);
                                  return Text(
                                    '$binStart',
                                    style: const TextStyle(fontSize: 10),
                                  );
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
                          borderData: FlBorderData(show: false),
                          gridData: const FlGridData(show: true),
                          barGroups: List.generate(ageBins.length, (index) {
                            return BarChartGroupData(
                              x: index,
                              barRods: [
                                BarChartRodData(
                                  toY: ageBins[index].toDouble(),
                                  color: Colors.blue,
                                  width: 24,
                                  borderRadius: BorderRadius.zero,
                                  borderSide: BorderSide(
                                    color: Color(0xffCADBFF),
                                    width: .5,
                                  ),
                                ),
                              ],
                            );
                          }),
                        ),
                      ),
                    ),
                  ),
                  const Text(
                    "อายุ",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  Future<List<int>> _loadData() async {
    // Load the CSV file from assets
    final String csvString = await rootBundle.loadString(csvFilePath);

    // Parse the CSV file into a list of lists
    List<List<dynamic>> csvData = const CsvToListConverter().convert(csvString);

    // Assume the first row is headers, and the age data is in the second column
    List<int> patientAges = [];
    for (int i = 1; i < csvData.length; i++) {
      var age = csvData[i][1]; // Assuming age is in the second column
      if (age is int) {
        patientAges.add(age);
      } else if (age is String) {
        patientAges.add(int.tryParse(age) ?? 0); // Handle invalid age as 0
      }
    }

    return patientAges;
  }
}
