import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pulse/utils/MEWsForms.dart';
import 'package:pulse/utils/actionButton.dart';
import 'package:pulse/utils/note_viewer.dart';
import 'package:pulse/utils/nursing.dart';
import 'package:pulse/utils/patientDetails.dart';
import 'package:pulse/utils/timeManager.dart';

class Patient {
  final String name;
  final String surname;
  final int age;
  final int MEWs;
  final DateTime lastUpdate;
  final String bedNumber;
  final String hn;
  final String ward;
  final List<String> note;

  Patient({
    required this.name,
    required this.surname,
    required this.age,
    required this.MEWs,
    required this.lastUpdate,
    required this.bedNumber,
    required this.hn,
    required this.ward,
    this.note = const [],
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
    note: ["Info 1", "Info 2"], // Add rows of additional information
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
    note: ["Info A", "Info B", "Info C"],
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
    note: ["Detail X", "Detail Y"],
  ),
];

class PatientList extends StatefulWidget {
  const PatientList({super.key});

  @override
  // ignore: library_private_types_in_public_api
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
                height: 80,
                child: Card(
                  color: const Color(0xffE0EAFF),
                  margin: EdgeInsets.zero,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                        bottomLeft: Radius.circular(12)),
                  ),
                  elevation: 1,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 17.0, horizontal: 12.0),
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Color(0xffFAD505),
                                shape: BoxShape.circle,
                              ),
                              width: 45,
                              height: 45,
                              alignment: Alignment.center,
                              child: Stack(
                                children: [
                                  Text(
                                    patient.MEWs.toString(),
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.transparent,
                                      shadows: [
                                        Shadow(
                                          offset: const Offset(1, 1),
                                          blurRadius: 10,
                                          color: Colors.black.withOpacity(0.25),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    patient.MEWs.toString(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25,
                                    ),
                                  ),
                                ],
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
                                  showTimeManager(context);
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
                                Radius.circular(_isExpanded[index] ? 0 : 12),
                            bottomRight:
                                Radius.circular(_isExpanded[index] ? 0 : 12),
                          ),
                        ),
                        backgroundColor: const Color(0xff98B1E8),
                        elevation: 1,
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
                          const SizedBox(width: 5),
                          Icon(
                            _isExpanded[index]
                                ? FontAwesomeIcons.angleUp
                                : FontAwesomeIcons.angleDown,
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
                      decoration: const BoxDecoration(
                        color: Color(0xff98B1E8),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                        ),
                      ),
                      child: Column(
                        children: [
                          ...patient.note.map((info) {
                            return Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: SizedBox(
                                  height: 30,
                                  child: TextFormField(
                                    initialValue: info,
                                    decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      filled: true,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 12.0),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide.none,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide.none,
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide.none,
                                      ),
                                      suffixIcon: const Icon(
                                        FontAwesomeIcons.pen,
                                        color: Color(0xff565656),
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                ));
                          }),
                          SizedBox(
                            height: 30,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xff3362CC),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding:
                                      const EdgeInsets.only(left: 0, right: 0)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'addMoreTime'.tr(),
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 12),
                                  ),
                                  const SizedBox(width: 5),
                                  const Icon(FontAwesomeIcons.plus,
                                      color: Colors.white)
                                ],
                              ),
                            ),
                          ),
                        ],
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
