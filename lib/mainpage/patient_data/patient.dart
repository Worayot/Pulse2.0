// ignore_for_file: library_private_types_in_public_api

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:pulse/authentication/element_setting/sizes.dart';
import 'package:pulse/func/get_color.dart';
import 'package:pulse/utils/action_button.dart';
import 'package:pulse/utils/circle_with_num.dart';
import 'package:pulse/utils/table_row.dart';
import 'package:pulse/utils/time_manager.dart';

class Patient {
  final String name;
  final String surname;
  final DateTime? nextMonitoring;
  final List<Map<String, dynamic>>? previousData;

  Patient(
      {required this.name,
      required this.surname,
      this.nextMonitoring,
      this.previousData});
}

class PatientPage extends StatefulWidget {
  const PatientPage({super.key});

  @override
  _PatientPageState createState() => _PatientPageState();
}

class _PatientPageState extends State<PatientPage> {
  final List<Patient> _patients = [
    Patient(
        name: "Mike",
        surname: "Johnson",
        nextMonitoring: DateTime.now(),
        previousData: [
          {"4:30": "2"},
          {"5:30": "1"}
        ]),
    Patient(
        name: "John",
        surname: "Doe",
        nextMonitoring: DateTime.now().add(const Duration(hours: 3)),
        previousData: [
          {"1:30": "5"},
          {"2:30": "4"},
          {"3:30": "3"},
          {"4:30": "2"},
          {"5:30": "-"}
        ]),
    Patient(
        name: "Chicky",
        surname: "Cutie",
        nextMonitoring: DateTime.now(),
        previousData: [
          {"1:30": "3"},
        ]),
    Patient(
        name: "Jane",
        surname: "Smith",
        nextMonitoring: DateTime.now().add(const Duration(hours: 2)),
        previousData: [
          {"1:30": "5"},
          {"2:30": "4"},
          {"3:30": "-"},
        ]),
    Patient(
        name: "Mike",
        surname: "Johnson",
        nextMonitoring: DateTime.now(),
        previousData: []),
    Patient(
        name: "Mike",
        surname: "Johnson",
        nextMonitoring: DateTime.now(),
        previousData: [
          {"5:30": '-'}
        ]),
    Patient(
        name: "วรยศ",
        surname: "เลี่ยมแก้ว",
        nextMonitoring: DateTime.now(),
        previousData: [
          {"1:30": "7"},
        ]),
    Patient(
        name: "Hello",
        surname: "World",
        nextMonitoring: DateTime.now(),
        previousData: [
          {"1:30": "5"},
          {"2:30": "4"},
          {"3:30": "3"},
          {"4:30": "2"},
          {"1:30": "5"},
          {"2:30": "4"},
          {"3:30": "3"},
          {"4:30": "2"},
          {"5:30": "-"}
        ]),
  ];

  final List<bool> _expandedStates = [];

  @override
  void initState() {
    super.initState();
    // Initialize all cards as collapsed
    _expandedStates.addAll(List<bool>.filled(_patients.length, false));
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    double paddingSize = screenWidth * 0.04; // Responsive padding

    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.only(left: paddingSize),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              "patientInMonitoring".tr(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: getPageTitleSize(context),
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(paddingSize),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _patients.length,
                itemBuilder: (context, index) {
                  Patient patient = _patients[index];

                  DateTime monitorTime =
                      patient.nextMonitoring ?? DateTime.now();
                  String formattedDatetime =
                      DateFormat('HH.mm').format(monitorTime);
                  Duration timeDifference =
                      monitorTime.difference(DateTime.now());

                  int hours = timeDifference.inHours;
                  int minutes = timeDifference.inMinutes % 60;

                  String formattedTime = '';
                  if (hours > 0 || minutes > 0) {
                    formattedTime += '(';
                  }
                  if (hours > 0) {
                    formattedTime += '$hours ${"hour".tr()} ';
                  }
                  if (minutes > 0) {
                    formattedTime += '$minutes ${"minute".tr()})';
                  }
                  if (formattedTime.isEmpty) {
                    formattedTime = '';
                  }

                  bool isExpanded = _expandedStates[index];
                  List<Map<String, dynamic>> data = patient.previousData ?? [];
                  int data_length = data.length;
                  List<String> times = [];
                  List<String> previous_MEWs = [];

                  for (var map in data) {
                    for (var entry in map.entries) {
                      times.add(entry.key);
                      previous_MEWs.add(entry.value);
                    }
                  }

                  String latest_MEWs = "";
                  if (previous_MEWs.isEmpty) {
                    latest_MEWs = "-";
                  } else if (previous_MEWs.length == 1) {
                    latest_MEWs = previous_MEWs[0];
                  } else if (previous_MEWs.length > 1 &&
                      previous_MEWs.last == "-") {
                    latest_MEWs = previous_MEWs[previous_MEWs.length - 2];
                  } else {
                    latest_MEWs = previous_MEWs.last;
                  }

                  bool hasData = data.isEmpty;

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Stack(
                      children: [
                        // Expanded Content
                        Positioned(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  16), // Match the container's radius
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    _expandedStates[index] =
                                        !_expandedStates[index]; // Toggle state
                                  });
                                },
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 250),
                                  curve: Curves.easeInOut,
                                  padding: const EdgeInsets.only(top: 16),
                                  height:
                                      isExpanded ? 86 + (data_length * 40) : 86,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: const Color(0xff98B1E8),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: isExpanded
                                      ? SizedBox(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const SizedBox(height: 70),
                                              Flexible(
                                                // Prevent overflow by constraining height
                                                child: ListView.builder(
                                                  shrinkWrap: true,
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  itemCount: data_length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    String MEWs =
                                                        previous_MEWs[index];
                                                    String time = times[index];
                                                    return TableRowWidget(
                                                        MEWs: MEWs, time: time);
                                                  },
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      : const SizedBox(),
                                ),
                              ),
                            ),
                          ),
                        ),

                        // Collapsed Header
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 0),
                          decoration: BoxDecoration(
                            color: const Color(0xffE0EAFF),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    _expandedStates[index] =
                                        !_expandedStates[index]; // Toggle state
                                  });
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 4.0, right: 12),
                                      child: CircleWithNumber(
                                        number: latest_MEWs,
                                        color: getColor(latest_MEWs),
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${patient.name} ${patient.surname}",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: screenWidth * 0.04,
                                              shadows: [
                                                Shadow(
                                                  color: Colors.black.withOpacity(
                                                      0.25), // Shadow color with opacity
                                                  offset: const Offset(0.8,
                                                      0.8), // Horizontal and vertical offset
                                                  blurRadius: 1, // Blur radius
                                                ),
                                              ],
                                            ),
                                          ),
                                          Text(
                                            "nextInspectionTime".tr(),
                                            style: TextStyle(
                                                fontSize: screenWidth * 0.03),
                                          ),
                                          const SizedBox(height: 2),
                                          Text(
                                            "$formattedDatetime${"n".tr()} $formattedTime",
                                            style: TextStyle(
                                                fontSize: screenWidth * 0.03),
                                          ),
                                        ],
                                      ),
                                    ),
                                    buildActionButton(
                                      FontAwesomeIcons.solidClock,
                                      () {
                                        showTimeManager(context);
                                      },
                                      Colors.white,
                                      const Color(0xff3362CC),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Assess Text and Icon
                        if (!hasData)
                          Positioned(
                            top: 73, // Adjust the position to fit your layout
                            left: screenWidth / 2.5,
                            child: Row(
                              children: [
                                Text("assess".tr()), // This stays in place
                                Icon(
                                  isExpanded
                                      ? Icons.expand_less
                                      : Icons.expand_more,
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
