import 'package:flutter/material.dart';

class FrozenColumnTable extends StatelessWidget {
  final List<List<String>> data = [
    ['1001', 'General', '5', '21', '2', '45'],
    ['1002', 'ICU', '3', '30', '1', '60'],
    ['1003', 'Pediatrics', '4', '18', '3', '50'],
    ['1004', 'General', '2', '25', '4', '30'],
    ['1005', 'Surgery', '5', '27', '2', '65'],
  ];

  final List<String> columnHeaders = [
    'Patient ID',
    'Ward',
    'Heart Rate',
    'Temperature',
    'BP',
    'Oxygen'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Frozen Column Table")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Stack to layer fixed columns and scrollable part
            Expanded(
              child: Row(
                children: [
                  // Fixed part: First two columns (Patient ID and Ward)
                  SizedBox(
                    width: 240, // Set a fixed width for the left side columns
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 120, // Width for first column
                              child: const Text('Patient ID',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ),
                            Container(
                              width: 120, // Width for second column
                              child: const Text('Ward',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                        const Divider(),
                        // Data rows for fixed columns
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: data.map((row) {
                                return Row(
                                  children: [
                                    Container(
                                      width: 120,
                                      child: Text(row[0]), // Patient ID
                                    ),
                                    Container(
                                      width: 120,
                                      child: Text(row[1]), // Ward
                                    ),
                                  ],
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Scrollable part: Rest of the columns (Heart Rate, Temperature, etc.)
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Column(
                        children: [
                          Row(
                            children: List.generate(
                              columnHeaders.length - 2,
                              (index) {
                                return Container(
                                  width: 120,
                                  child: Text(
                                    columnHeaders[index + 2],
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                );
                              },
                            ),
                          ),
                          const Divider(),
                          // Data rows for scrollable columns
                          ...data.map((row) {
                            return Row(
                              children: List.generate(
                                columnHeaders.length - 2,
                                (index) {
                                  return Container(
                                    width: 120,
                                    child:
                                        Text(row[index + 2]), // Other columns
                                  );
                                },
                              ),
                            );
                          }).toList(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: FrozenColumnTable(),
  ));
}
