import 'package:flutter/material.dart';
import 'package:pulse/utils/DateNavigation.dart';

class ReportTable extends StatelessWidget {
  const ReportTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const SizedBox(height: 7),
          const DateNavigation(),
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xffC6D8FF),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(4),
                    ),
                  ),
                  child: const DataTableWidget(
                    headers: ['D/M/Y', 'Time'],
                    rows: [
                      ["12/11/2023", "10:00"],
                      ["13/11/2023", "10:30"],
                      ["14/11/2023", "11:00"],
                    ],
                    columnSpacing:
                        0, // Custom column spacing for the first table
                    textStyle: TextStyle(
                        fontSize: 12, color: Colors.black), // Custom text style
                    headerTextStyle: TextStyle(
                        fontSize: 14,
                        fontWeight:
                            FontWeight.bold), // Custom header text style
                    columnWidth: 80,
                    dynamicColumnIndex:
                        -1, // No dynamic column for the first table
                  ),
                ),
              ),

              // Second Table with different custom properties
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xffC6D8FF),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(4),
                    ),
                  ),
                  child: NotificationListener<ScrollNotification>(
                    onNotification: (scrollNotification) {
                      if (scrollNotification is ScrollUpdateNotification) {
                        // Disable scrolling when at the far left (scroll offset is zero)
                        if (scrollNotification.metrics.pixels == 0) {
                          return true; // Prevent further scrolling to the left
                        }
                      }
                      return false;
                    },
                    child: SingleChildScrollView(
                      scrollDirection:
                          Axis.horizontal, // Allow horizontal scroll
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: 1200, // Set the maximum width for the table
                        ),
                        child: const DataTableWidget(
                          headers: [
                            'C',
                            'T',
                            'P',
                            'R',
                            'BP',
                            'O2 Sat',
                            'Urine',
                            'Total Score\n(MEWs)',
                            'CVP',
                            'Management'
                          ],
                          rows: [
                            [
                              "36.5",
                              "98.6",
                              "72",
                              "16",
                              "120/80",
                              "98%",
                              "500ml",
                              "5",
                              "2",
                              "Observation"
                            ],
                            [
                              "36.7",
                              "99.0",
                              "76",
                              "17",
                              "118/79",
                              "97%",
                              "450ml",
                              "4",
                              "2",
                              "Checkup"
                            ],
                            [
                              "37.0",
                              "100.0",
                              "80",
                              "18",
                              "115/78",
                              "96%",
                              "400ml",
                              "6",
                              "2",
                              "Medications"
                            ],
                          ],
                          columnSpacing:
                              9, // Custom column spacing for the second table
                          textStyle: TextStyle(
                              fontSize: 12,
                              color: Colors.black), // Custom text style
                          headerTextStyle: TextStyle(
                              fontSize: 14,
                              fontWeight:
                                  FontWeight.w600), // Custom header text style
                          columnWidth: 80,
                          dynamicColumnIndex: 9,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DataTableWidget extends StatelessWidget {
  final List<String> headers;
  final List<List<String>> rows;
  final double columnSpacing;
  final TextStyle textStyle;
  final TextStyle headerTextStyle;
  final double columnWidth;
  final int dynamicColumnIndex;

  const DataTableWidget({
    super.key,
    required this.headers,
    required this.rows,
    required this.columnSpacing,
    required this.textStyle,
    required this.headerTextStyle,
    required this.columnWidth,
    required this.dynamicColumnIndex, // Accept dynamic column index
  });

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columnSpacing: columnSpacing, // Custom column spacing
      columns: headers.map((header) {
        return DataColumn(
          label: Center(
            child: Text(
              header,
              style: headerTextStyle, // Custom header text style
            ),
          ),
          numeric: false, // Ensure columns are not numeric
        );
      }).toList(),
      rows: List<DataRow>.generate(
        rows.length,
        (index) => DataRow(
          color: WidgetStateProperty.resolveWith<Color?>((states) {
            return index % 2 == 0 ? Colors.white : Colors.grey[200];
          }),
          cells: rows[index].map((cell) {
            // For the dynamic "Management" column, use no fixed width
            return DataCell(
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 3),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: index == dynamicColumnIndex
                        ? 120
                        : columnWidth, // Dynamic width for "Management" column
                    // maxWidth: index == dynamicColumnIndex
                    //     ? double.infinity
                    //     : columnWidth, // No max width for "Management"
                  ),
                  child: Text(
                    cell,
                    softWrap: true, // Allows text to wrap
                    style: textStyle, // Custom text style for cell
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
