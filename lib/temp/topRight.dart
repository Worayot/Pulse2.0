import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';

class EmergencyCase extends StatelessWidget {
  final String csvFilePath;

  const EmergencyCase({Key? key, required this.csvFilePath}) : super(key: key);

  Future<List<Map<String, String>>> loadCSVData() async {
    final data = await rootBundle.loadString(csvFilePath);
    final List<List<dynamic>> csvTable = CsvToListConverter().convert(data);

    // Skip header row and extract "Name" and "MEWS" columns
    return csvTable.skip(1).map((row) {
      return {
        'Name': row[1].toString(), // Assuming the second column is "Name"
        'MEWS': row[2].toString(), // Assuming the third column is "MEWS"
      };
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, String>>>(
      future: loadCSVData(),
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
          return AlertDialog(
            title: Row(
              children: [
                const Text('เฝ้าระวังเป็นพิเศษ'),
                const Spacer(),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const Icon(Icons.close),
                ),
              ],
            ),
            content: SizedBox(
              width: double.maxFinite,
              height: 300, // Adjust height as needed
              child: ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final item = snapshot.data![index];
                  return ListTile(
                    leading: Text('${index + 1}'), // Display row number
                    title: Text(item['Name'] ?? ''), // Display name
                    subtitle:
                        Text('MEWS: ${item['MEWS'] ?? ''}'), // Display MEWS
                  );
                },
              ),
            ),
          );
        }
      },
    );
  }
}
