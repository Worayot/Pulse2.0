import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:csv/csv.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Patient {
  final int id;
  final String ward;

  Patient({required this.id, required this.ward});

  factory Patient.fromCsv(List<dynamic> row) {
    return Patient(
      id: row[0],
      ward: row[1],
    );
  }
}

class WardHistogram extends StatelessWidget {
  const WardHistogram({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: Container(
          width: 300, // Set desired width
          height: 600, // Set desired height
          child: Scaffold(
            appBar: AppBar(
              title: Row(
                children: [
                  const Text('จำแนกด้วยหอผู้ป่วย'),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const Icon(FontAwesomeIcons.xmark),
                  ),
                ],
              ),
              automaticallyImplyLeading: false, // Removes default back button
              // actions: [
              //   IconButton(
              //     icon: const Icon(FontAwesomeIcons.xmark),
              //     iconSize: 30, // Reduce the icon size
              //     onPressed: () => Navigator.of(context).pop(),
              //   ),
              // ],
            ),
            body: FutureBuilder<Map<String, int>>(
              future: countPatientsByWard(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No data available.'));
                } else {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 40.0, right: 10),
                    child: buildBarChart(snapshot.data!),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Future<Map<String, int>> countPatientsByWard() async {
    final patients = await loadData();

    // Count the number of patients in each ward
    final wardCounts = <String, int>{};
    for (var patient in patients) {
      wardCounts[patient.ward] = (wardCounts[patient.ward] ?? 0) + 1;
    }

    return wardCounts;
  }

  Future<List<Patient>> loadData() async {
    // Load CSV file as a string
    final csvString = await rootBundle.loadString('assets/BottomRight.csv');

    // Parse the CSV string
    final List<List<dynamic>> csvData =
        const CsvToListConverter().convert(csvString, eol: "\n");

    // Convert each row into a Patient object, skipping the header
    final patients =
        csvData.skip(1).map((row) => Patient.fromCsv(row)).toList();

    return patients;
  }

  Widget buildBarChart(Map<String, int> wardCounts) {
    final wards = wardCounts.keys.toList();
    final counts = wardCounts.values.toList();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          barTouchData: BarTouchData(enabled: false),
          titlesData: FlTitlesData(
            leftTitles: const AxisTitles(
              sideTitles:
                  SideTitles(showTitles: true, reservedSize: 30, interval: 5),
            ),
            topTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  final wardIndex = value.toInt();
                  return (wardIndex >= 0 && wardIndex < wards.length)
                      ? Transform.rotate(
                          angle: -1, // 90 degrees counterclockwise
                          child: Padding(
                            padding: const EdgeInsets.only(
                              right: 50.0,
                            ), // Increased padding for more space
                            child: Text(
                              wards[wardIndex],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        )
                      : const SizedBox.shrink();
                },
                interval: 1,
              ),
            ),
          ),
          gridData: FlGridData(show: true),
          minY: 0,
          maxY: 25,
          barGroups: List.generate(
            wards.length,
            (index) => BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  toY: counts[index].toDouble(),
                  color: Colors.blue,
                  width: 20,
                  borderRadius: BorderRadius.zero,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
