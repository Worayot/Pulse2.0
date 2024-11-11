// ignore_for_file: library_private_types_in_public_api

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:pulse/func/DateNavigation.dart';
import 'package:pulse/utils/actionButton.dart';
import 'package:pulse/utils/infoDialog.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "patientInList".tr(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ))),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 25, top: 23),
            child: IconButton(
              icon: const FaIcon(FontAwesomeIcons.circleInfo,
                  size: 25, // Size of the icon
                  color: Color(0xff3362CC) // Color of the icon
                  ),
              onPressed: () {
                showInfoDialog(context);
              },
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: _filterPatients,
                    decoration: const InputDecoration(
                      hintText: "Search...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: Icon(
                        FontAwesomeIcons.magnifyingGlass,
                        color: Colors.black,
                      ),
                      filled: true, // Enables the background color
                      fillColor: Color(0xffCADBFF), // Sets the background color
                      labelStyle: TextStyle(color: Colors.black),
                    ),
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: 120,
                  height: 55,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Placeholder for Add Patient functionality
                    },
                    icon: const Icon(
                      FontAwesomeIcons.userPlus,
                      size: 25,
                      color: Colors.white,
                    ),
                    label: const Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Add Patient",
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                        // overflow: TextOverflow.clip,
                        softWrap: true,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff407bff),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
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
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${patient.name} ${patient.surname}",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Text(
                                          "Bed Number: ${patient.bedNumber}",
                                          style: const TextStyle(fontSize: 11),
                                        ),
                                        Text(
                                          "Last Updated: ${DateFormat('dd/MM/yyyy HH:mm').format(patient.lastUpdate)}",
                                          style: const TextStyle(fontSize: 10),
                                        ),
                                      ],
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
                              editDetail();
                            }, Colors.white, const Color(0xff3362CC)),
                            const SizedBox(width: 10),
                            buildActionButton(FontAwesomeIcons.list, () {
                              showInfo();
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
}

void addToCare() {}
void editDetail() {}
void showInfo() {}
