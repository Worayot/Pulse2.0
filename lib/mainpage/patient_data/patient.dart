// ignore_for_file: library_private_types_in_public_api

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:pulse/mainpage/patient_data/patient_data.dart';
import 'package:pulse/utils/action_button.dart';
import 'package:pulse/utils/add_patient_form.dart';
import 'package:pulse/utils/edit_patient_form.dart';
import 'package:pulse/utils/mews_forms.dart';
import 'package:pulse/utils/symbols_dialog/info_dialog.dart';
import 'package:pulse/utils/symbols_dialog/patient_symbols.dart';

class Patient {
  final String name;
  final String surname;
  final int bedNumber;
  final DateTime lastUpdate;

  Patient({
    required this.name,
    required this.surname,
    required this.bedNumber,
    required this.lastUpdate,
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
        bedNumber: 1,
        lastUpdate: DateTime.now().subtract(const Duration(hours: 1))),
    Patient(
        name: "Jane",
        surname: "Smith",
        bedNumber: 2,
        lastUpdate: DateTime.now().subtract(const Duration(hours: 2))),
    Patient(
        name: "Mike",
        surname: "Johnson",
        bedNumber: 3,
        lastUpdate: DateTime.now().subtract(const Duration(hours: 3))),
  ];

  List<Patient> _filteredPatients = [];
  String _searchText = '';

  @override
  void initState() {
    super.initState();
    _filteredPatients = _patients; // Initialize with all patients
  }

  void _filterPatients(String query) {
    setState(() {
      _searchText = query.toLowerCase();
      _filteredPatients = _patients.where((patient) {
        return patient.name.toLowerCase().contains(_searchText) ||
            patient.surname.toLowerCase().contains(_searchText);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Getting screen size information
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    // Adjusting the UI elements based on screen size
    double paddingSize = screenWidth * 0.04; // Responsive padding
    double iconSize = screenWidth * 0.08; // Responsive icon size
    double buttonHeight = screenHeight * 0.065; // Button height
    double searchBoxHeight = screenHeight * 0.06; // Search box height, unused

    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.only(left: paddingSize),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              "patientInList".tr(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: screenWidth * 0.05, // Responsive text size
              ),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: paddingSize),
            child: IconButton(
              icon: FaIcon(
                FontAwesomeIcons.circleInfo,
                size: iconSize, // Responsive icon size
                color: const Color(0xff3362CC),
              ),
              onPressed: () {
                showInfoDialog(context, patientSymbols());
              },
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(paddingSize),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: _filterPatients,
                    decoration: InputDecoration(
                      hintText: "${"search".tr()}...",
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: const Icon(
                        FontAwesomeIcons.magnifyingGlass,
                        color: Colors.black,
                      ),
                      filled: true,
                      fillColor: const Color(0xffCADBFF),
                      labelStyle: const TextStyle(color: Colors.black),
                    ),
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: 120,
                  height: buttonHeight,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const AddPatientForm();
                        },
                      );
                    },
                    icon: const Icon(
                      FontAwesomeIcons.userPlus,
                      size: 25,
                      color: Colors.white,
                    ),
                    label: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "addPatient".tr(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        softWrap: true,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff407bff),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 0),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _filteredPatients.length,
                itemBuilder: (context, index) {
                  final patient = _filteredPatients[index];
                  return Stack(
                    children: [
                      Card(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        color: const Color(0xffE0EAFF),
                        child: ListTile(
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return const MEWsForms();
                                            });
                                      },
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${patient.name} ${patient.surname}",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: screenWidth *
                                                  0.04, // Responsive text size
                                            ),
                                          ),
                                          Text(
                                            "Bed Number: ${patient.bedNumber}",
                                            style: TextStyle(
                                                fontSize: screenWidth * 0.032),
                                          ),
                                          Text(
                                            "Last Updated: ${DateFormat('dd/MM/yyyy HH:mm').format(patient.lastUpdate)}",
                                            style: TextStyle(
                                                fontSize: screenWidth * 0.027),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: ClipRect(
                          child: SizedBox(
                            height: 100,
                            width: 180,
                            child: Image.asset(
                              'assets/images/therapy3.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        bottom: 0,
                        right: 10,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            buildActionButton(FontAwesomeIcons.plus, () {
                              addToCare();
                            }, Colors.white, const Color(0xff3362CC)),
                            const SizedBox(width: 10),
                            buildActionButton(FontAwesomeIcons.penClip, () {
                              editDetail(context);
                            }, Colors.white, const Color(0xff3362CC)),
                            const SizedBox(width: 10),
                            buildActionButton(FontAwesomeIcons.list, () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const PatientData(),
                                ),
                              );
                            }, Colors.white, const Color(0xff3362CC)),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build action buttons
  void editDetail(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return const EditPatientForm();
        });
  }
}

void addToCare() {}
