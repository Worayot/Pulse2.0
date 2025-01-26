// ignore_for_file: library_private_types_in_public_api

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:pulse/func/get_color.dart';
import 'package:pulse/utils/action_button.dart';
import 'package:pulse/utils/circle_with_num.dart';

class Patient {
  final String name;
  final String surname;
  final int MEWs;
  final DateTime? nextMonitoring;

  Patient({
    required this.name,
    required this.surname,
    required this.MEWs,
    this.nextMonitoring,
  });
}

class PatientPage extends StatefulWidget {
  const PatientPage({super.key});

  @override
  _PatientPageState createState() => _PatientPageState();
}

class _PatientPageState extends State<PatientPage> {
  final List<Patient> _patients = [
    Patient(
      name: "John",
      surname: "Doe",
      MEWs: 1,
      nextMonitoring: DateTime.now().add(const Duration(hours: 3)),
    ),
    Patient(
      name: "Jane",
      surname: "Smith",
      MEWs: 2,
      nextMonitoring: DateTime.now().add(const Duration(hours: 2)),
    ),
    Patient(
      name: "Mike",
      surname: "Johnson",
      MEWs: 3,
      nextMonitoring: DateTime.now(),
    ),
    Patient(
      name: "Mike",
      surname: "Johnson",
      MEWs: 4,
      nextMonitoring: DateTime.now(),
    ),
    Patient(
      name: "Mike",
      surname: "Johnson",
      MEWs: 5,
      nextMonitoring: DateTime.now(),
    ),
    Patient(
      name: "Mike",
      surname: "Johnson",
      MEWs: 6,
      nextMonitoring: DateTime.now(),
    ),
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
                fontSize: screenWidth * 0.05,
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
                  int MEWs = patient.MEWs;
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

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Stack(
                      children: [
                        // Expanded Content
                        Positioned(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: AnimatedContainer(
                                duration: const Duration(milliseconds: 250),
                                curve: Curves.easeInOut,
                                padding: const EdgeInsets.only(top: 16),
                                height: isExpanded ? 160 : 90,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: const Color(0xff98B1E8),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: isExpanded
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(height: 8),
                                          Text(
                                            "Additional details can go here...",
                                            style: TextStyle(
                                                fontSize: screenWidth * 0.03),
                                          ),
                                        ],
                                      )
                                    : const SizedBox()),
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
                                          number: MEWs, color: getColor(MEWs)),
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
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            "nextInspectionTime".tr(),
                                            style: TextStyle(
                                                fontSize: screenWidth * 0.03),
                                          ),
                                          const SizedBox(height: 2),
                                          Text(
                                            "$formattedDatetime ${"n".tr()} $formattedTime",
                                            style: TextStyle(
                                                fontSize: screenWidth * 0.03),
                                          ),
                                        ],
                                      ),
                                    ),
                                    buildActionButton(
                                      FontAwesomeIcons.solidClock,
                                      () {},
                                      Colors.white,
                                      const Color(0xff3362CC),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 77, // Adjust the position to fit your layout

                          left: screenWidth / 2.5,

                          child: Row(
                            children: [
                              Text("assess".tr()), // This stays in place
                              Icon(
                                isExpanded
                                    ? Icons.expand_less
                                    : Icons.expand_more,
                              )
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
