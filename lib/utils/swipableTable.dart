import 'package:flutter/material.dart';

class SwipableTable extends StatelessWidget {
  const SwipableTable({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal, // Horizontal scrolling
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical, // Vertical scrolling
        child: DataTable(
          headingRowColor: WidgetStateProperty.all(const Color(0xFFC6D8FF)),
          columns: const [
            DataColumn(label: Text('Time')),
            DataColumn(label: Text('C')),
            DataColumn(label: Text('T')),
            DataColumn(label: Text('P')),
            DataColumn(label: Text('R')),
            DataColumn(label: Text('BP')),
            DataColumn(label: Text('O2, Sat')),
            DataColumn(label: Text('Urine')),
            DataColumn(label: Text('Total Score (MEWs)')),
            DataColumn(label: Text('CVP')),
            DataColumn(label: Text('Management')),
          ],
          rows: List.generate(15, (index) {
            return DataRow(
              cells: const [
                DataCell(Text('08:00')),
                DataCell(Text('98')),
                DataCell(Text('37.5')),
                DataCell(Text('120')),
                DataCell(Text('18')),
                DataCell(Text('120/80')),
                DataCell(Text('98%, 95')),
                DataCell(Text('0.5L')),
                DataCell(Text('3')),
                DataCell(Text('14')),
                DataCell(Text('Medication')),
              ],
              color: WidgetStateProperty.all(
                  index.isOdd ? const Color(0xffF5F5F5) : Colors.white),
            );
          }),
        ),
      ),
    );
  }
}
