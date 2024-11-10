import 'dart:math';

import 'package:csv/csv.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:pulse/authentication/login.dart';
import 'package:pulse/temp/BottomRight.dart';
import 'package:pulse/temp/bottomLeft.dart';
import 'package:pulse/temp/topLeft.dart';
import 'package:pulse/temp/topRight.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<List<dynamic>> _patientData = [];
  int _selectedLanguageIndex = 1;
  late ScrollController _scrollController;
  int _visibleRowsCount = 10;

  @override
  void initState() {
    super.initState();
    _loadCSV();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  // Listen for scroll events to load more data
  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      // When the user scrolls to the bottom, load more rows
      setState(() {
        _visibleRowsCount =
            (_visibleRowsCount + 10).clamp(0, _patientData.length - 1);
      });
    }
  }

  Future<void> _loadCSV() async {
    final csvData = await rootBundle.loadString('assets/PatientData.csv');
    List<List<dynamic>> csvTable = CsvToListConverter().convert(csvData);
    setState(() {
      _patientData = csvTable;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 60),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                    );
                  },
                  borderRadius: BorderRadius.circular(8),
                  child: const Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          FontAwesomeIcons.arrowLeft,
                          color: Colors.black,
                          size: 18,
                        ), // Icon on the left
                        SizedBox(width: 10),
                        Flexible(
                          child: Text(
                            "ออกจากระบบ",
                            overflow:
                                TextOverflow.ellipsis, // To prevent overflow
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ToggleButtons(
                      isSelected: [
                        _selectedLanguageIndex == 0,
                        _selectedLanguageIndex == 1
                      ],
                      onPressed: (int index) {
                        setState(() {
                          _selectedLanguageIndex = index;
                        });
                      },
                      borderRadius: BorderRadius.circular(10),
                      selectedColor: Colors.white,
                      fillColor: const Color(0xff1225A4),
                      color: Colors.black,
                      constraints:
                          const BoxConstraints(minWidth: 70, minHeight: 36),
                      children: const [
                        Text('English'),
                        Text('ไทย'),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Center(
              child: Text(
                "Dashboard",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const BigDashboardCard(
                      title: "สถิติ",
                      color: Color(0xffE0EAFF),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            _showTopLeft(context);
                          },
                          child: const DashboardCard(
                            icon: FontAwesomeIcons.democrat,
                            title: "จัดกลุ่มตามอายุ",
                            value: "120",
                            color: Colors.blue,
                            iconColor: Color(0xffE0EAFF),
                            height: 175,
                            width: 175,
                            iconSize: 50,
                          ),
                        ),
                        const SizedBox(width: 15),
                        InkWell(
                          onTap: () {
                            _showTopRight(context);
                          },
                          child: const DashboardCard(
                            icon: FontAwesomeIcons.chartColumn,
                            title: "เฝ้าระวังเป็นพิเศษ",
                            value: "35",
                            color: Colors.green,
                            iconColor: Color(0xffE0EAFF),
                            height: 175,
                            width: 175,
                            iconSize: 50,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            _showBottomLeft(context);
                          },
                          child: const DashboardCard(
                            icon: FontAwesomeIcons.chartColumn,
                            title: "จัดกลุ่มตามเพศ",
                            value: "5",
                            color: Colors.red,
                            iconColor: Color(0xffE0EAFF),
                            height: 175,
                            width: 175,
                            iconSize: 50,
                          ),
                        ),
                        const SizedBox(width: 15),
                        InkWell(
                          onTap: () {
                            _showBottomRight(context);
                          },
                          child: const DashboardCard(
                            icon: FontAwesomeIcons.republican,
                            title: "จัดกลุ่มตามหอผู้ป่วย",
                            value: "10",
                            color: Colors.orange,
                            iconColor: Color(0xffE0EAFF),
                            height: 175,
                            width: 175,
                            iconSize: 50,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    _buildPatientList(
                        _patientData, _visibleRowsCount, _scrollController),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void _showBottomRight(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return const WardHistogram();
      });
}

void _showTopLeft(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AgeHistogramDialog(
        csvFilePath: 'assets/TopLeft.csv',
      );
    },
  );
}

void _showTopRight(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return const EmergencyCase(
        csvFilePath: 'assets/TopRight.csv',
      );
    },
  );
}

void _showBottomLeft(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return GenderBarChartDialog(
        csvFilePath: 'assets/BottomLeft.csv', // Path to the CSV file
      );
    },
  );
}

Widget buildSearchBar() {
  return Container(
    height: 40,
    width: 270,
    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(35),
      // boxShadow: [
      //   BoxShadow(
      //     color: Colors.black.withOpacity(0.1),
      //     blurRadius: 5,
      //     offset: Offset(0, 2),
      //   ),
      // ],
    ),
    child: const TextField(
      decoration: InputDecoration(
        hintText: "ค้นหา...",
        hintStyle: TextStyle(color: Colors.grey),
        border: InputBorder.none,
        prefixIcon: Icon(Icons.search, color: Colors.black),
      ),
    ),
  );
}

Widget _buildPatientList(List<List<dynamic>> _patientData, int visibleRowsCount,
    ScrollController _scrollController) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: const Color(0xffE0EAFF),
      borderRadius: BorderRadius.circular(15),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              "รายชื่อผู้ป่วย",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff407BFF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: const Row(
                children: [
                  Icon(FontAwesomeIcons.filter, color: Colors.white, size: 15),
                  SizedBox(width: 6),
                  Text(
                    "กรองข้อมูล",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xff000000).withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'ผู้ป่วย',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
                child: buildSearchBar()) // Ensure buildSearchBar() is defined
          ],
        ),
        const SizedBox(height: 20),
        _patientData.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : Container(
                decoration: BoxDecoration(
                  color: Colors.white, // Set background color to white
                  borderRadius: BorderRadius.circular(15), // Set border radius
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  controller: _scrollController, // Attach scroll controller
                  child: DataTable(
                    columns: _patientData[0]
                        .map((header) =>
                            DataColumn(label: Text(header.toString())))
                        .toList(),
                    rows: _patientData
                        .sublist(1, visibleRowsCount)
                        .asMap()
                        .map((index, row) {
                          // Alternate row colors
                          Color rowColor = (index % 2 == 0)
                              ? Colors.grey[200]!
                              : Colors.white;
                          return MapEntry(
                            index,
                            DataRow(
                              cells: row
                                  .map(
                                      (cell) => DataCell(Text(cell.toString())))
                                  .toList(),
                              color: MaterialStateProperty.all(rowColor),
                            ),
                          );
                        })
                        .values
                        .toList(),
                  ),
                ),
              ),
      ],
    ),
  );
}

class BigDashboardCard extends StatelessWidget {
  final String title;
  final Color color;

  const BigDashboardCard({
    super.key,
    required this.title,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 165,
      width: double.infinity,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(3, 3),
          ),
        ],
      ),
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      title,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color(0xff407BFF), // Set the background color
                      minimumSize: const Size(15, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            20), // Optional: rounded corners
                      ),
                    ),
                    child: const Text(
                      "นำออกข้อมูล",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 17),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DashboardCard2(
                    color: Colors.white,
                    icon: Icons.circle,
                    title: "ผู้ใช้",
                    value: "9",
                    height: 80,
                    width: 110,
                    iconColor: Color.fromARGB(255, 243, 216, 9),
                    // iconSize: 20,
                  ),
                  // SizedBox()
                  DashboardCard2(
                    color: Colors.white,
                    icon: Icons.circle,
                    title: "ผู้ใช้ที่ออนไลน์",
                    value: "6",
                    height: 80,
                    width: 110,
                    iconColor: Colors.green,
                    // iconSize: 20,
                  ),
                  DashboardCard2(
                    color: Colors.white,
                    icon: Icons.circle,
                    title: "คนไข้",
                    value: "5",
                    height: 80,
                    width: 110,
                    iconColor: Colors.blue,
                    // iconSize: 20,
                  ),
                ],
              )
            ],
          )),
    );
  }
}

class DashboardCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color color;
  final double height;
  final double width;
  final Color iconColor;
  final double iconSize;

  const DashboardCard(
      {required this.icon,
      required this.title,
      required this.value,
      required this.color,
      required this.height,
      required this.width,
      required this.iconColor,
      required this.iconSize});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2), // Shadow color with opacity
            spreadRadius: 4, // Spread of the shadow
            blurRadius: 8, // Blur radius of the shadow
            offset: const Offset(0, 2), // Position of the shadow (X, Y)
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: iconColor, size: iconSize),
            const SizedBox(height: 10),
            Text(
              textAlign: TextAlign.center,
              title,
              softWrap: true,
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold, color: iconColor),
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardCard2 extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color color;
  final double height;
  final double width;
  final Color iconColor;

  const DashboardCard2(
      {required this.icon,
      required this.title,
      required this.value,
      required this.color,
      required this.height,
      required this.width,
      required this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 10, color: iconColor),
              SizedBox(width: 5),
              Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                ),
                overflow: TextOverflow.fade,
              )
            ],
          ),
          Text(
            value,
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
