import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pulse/utils/MEWsForms.dart';
import 'package:pulse/utils/actionButton.dart';
import 'package:pulse/utils/nursing.dart';
import 'package:pulse/utils/patientDetails.dart';

class Patient {
  final String name;
  final String surname;
  final int age;
  final int MEWs;
  final DateTime lastUpdate;
  final String bedNumber;
  final String hn;
  final String ward;
  final List<String> additionalInfo;

  Patient({
    required this.name,
    required this.surname,
    required this.age,
    required this.MEWs,
    required this.lastUpdate,
    required this.bedNumber,
    required this.hn,
    required this.ward,
    this.additionalInfo = const [],
  });
}

final List<Patient> _patients = [
  Patient(
    name: "John",
    surname: "Doe",
    age: 12,
    hn: '01',
    bedNumber: "A",
    ward: "A1",
    MEWs: 5,
    lastUpdate: DateTime.now().subtract(const Duration(hours: 1)),
    additionalInfo: ["Info 1", "Info 2"], // Add rows of additional information
  ),
  Patient(
    name: "Jane",
    surname: "Smith",
    age: 15,
    hn: "02",
    bedNumber: "B",
    ward: "B1",
    MEWs: 5,
    lastUpdate: DateTime.now().subtract(const Duration(hours: 2)),
    additionalInfo: ["Info A", "Info B", "Info C"],
  ),
  Patient(
    name: "Mike",
    surname: "Johnson",
    MEWs: 5,
    age: 15,
    hn: "03",
    bedNumber: "C",
    ward: "C1",
    lastUpdate: DateTime.now().subtract(const Duration(hours: 3)),
    additionalInfo: ["Detail X", "Detail Y"],
  ),
];

class PatientList extends StatefulWidget {
  const PatientList({super.key});

  @override
  _PatientListState createState() => _PatientListState();
}

class _PatientListState extends State<PatientList> {
  late List<bool> _isExpanded;

  @override
  void initState() {
    super.initState();
    _isExpanded =
        List<bool>.filled(_patients.length, false); // Initialize the list
  }

  void _removePatient(int index) {
    setState(() {
      _patients.removeAt(index);
      _isExpanded.removeAt(index); // Remove expansion state as well
    });
  }

  @override
  Widget build(BuildContext context) {
    return buildPatientListHome();
  }

  Widget buildPatientListHome() {
    return Expanded(
      child: ListView.builder(
        itemCount: _patients.length,
        itemBuilder: (context, index) {
          final patient = _patients[index];
          return Column(
            children: [
              SizedBox(
                height: 70,
                child: Card(
                  color: const Color(0xffE0EAFF),
                  margin: EdgeInsets.zero,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20)),
                  ),
                  elevation: 0,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12.0, horizontal: 12.0),
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              width: 45,
                              height: 45,
                              alignment: Alignment.center,
                              child: Text(
                                patient.MEWs.toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 4.0),
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
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                      Text(
                                        "${"nextInspectionTime".tr()}:\n${DateFormat('HH:mm').format(patient.lastUpdate)} (" +
                                            "${"in".tr()} 15 ${"mins".tr()})",
                                        style: const TextStyle(fontSize: 10),
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                          SizedBox(
                              child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 12.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                buildActionButton(FontAwesomeIcons.solidClock,
                                    () {
                                  _showTimeManager(context);
                                }, Colors.white, const Color(0xff3362CC)),
                                const SizedBox(width: 4),
                                buildActionButton(FontAwesomeIcons.userNurse,
                                    () {
                                  showNursing(context, "1");
                                }, Colors.white, const Color(0xff3362CC)),
                                const SizedBox(width: 4),
                                buildActionButton(
                                    FontAwesomeIcons.clipboardList, () {
                                  showPatientDetails(context, patient);
                                }, Colors.white, const Color(0xff3362CC)),
                                const SizedBox(width: 4),
                                buildActionButton(FontAwesomeIcons.xmark, () {
                                  _removePatient(index); // Pass index to remove
                                }, Colors.red, Colors.white),
                              ],
                            ),
                          ))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 170,
                    height: 30,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _isExpanded[index] = !_isExpanded[index];
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            bottomLeft:
                                Radius.circular(_isExpanded[index] ? 0 : 20),
                            bottomRight:
                                Radius.circular(_isExpanded[index] ? 0 : 20),
                          ),
                        ),
                        backgroundColor: const Color(0xff98B1E8),
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _isExpanded[index]
                                ? "close".tr()
                                : "inspectionTime".tr(),
                            style: const TextStyle(color: Colors.black),
                          ),
                          Icon(
                            _isExpanded[index]
                                ? Icons.arrow_upward
                                : Icons.arrow_downward,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              if (_isExpanded[index])
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 170,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                      child: Column(
                        children: patient.additionalInfo.map((info) {
                          return Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  initialValue: info,
                                  decoration: const InputDecoration(
                                      border: UnderlineInputBorder()),
                                ),
                              ),
                              const Icon(Icons.edit, color: Colors.black)
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              const SizedBox(height: 16)
            ],
          );
        },
      ),
    );
  }
}

void _showTimeManager(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 0),
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15), // Adjust radius here
            ),
            title: Row(
              children: [
                Text(
                  "notifications".tr(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(
                    FontAwesomeIcons.xmark, // The icon to display
                    color: Colors.black, // Icon color
                    size: 30, // Icon size
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
            contentPadding:
                const EdgeInsets.only(left: 30, right: 30, bottom: 30),
            content: const Row(
              children: [],
            ),
          ),
        );
      });
}
