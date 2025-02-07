import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pulse/authentication/universal_setting/sizes.dart';
import 'package:pulse/mainpage/patient_data/patient_ind_data.dart';
import 'package:pulse/utils/edit_patient_form.dart';
import 'package:pulse/utils/action_button.dart';
import 'package:pulse/utils/patient_details.dart';
import 'package:pulse/utils/toggle_icon_button.dart';

import '../../utils/add_patient_form.dart';

class Patient1 {
  final String name;
  final String surname;
  final int age;
  final String gender;
  final int MEWs;
  final DateTime lastUpdate;
  final String bedNumber;
  final String hn;
  final String ward;
  final List<String> note;

  Patient1({
    required this.name,
    required this.surname,
    required this.age,
    required this.gender,
    required this.MEWs,
    required this.lastUpdate,
    required this.bedNumber,
    required this.hn,
    required this.ward,
    this.note = const [],
  });
}

final List<Patient1> _patients = [
  Patient1(
    name: "John",
    surname: "Doe",
    age: 12,
    gender: "Male",
    hn: '01',
    bedNumber: "A",
    ward: "A1",
    MEWs: 5,
    lastUpdate: DateTime.now().subtract(const Duration(hours: 1)),
    note: ["Info 1", "Info 2"],
  ),
  Patient1(
    name: "Jane",
    surname: "Smith",
    age: 15,
    gender: "Female",
    hn: "02",
    bedNumber: "B",
    ward: "B1",
    MEWs: 5,
    lastUpdate: DateTime.now().subtract(const Duration(hours: 2)),
    note: ["Info A", "Info B", "Info C"],
  ),
  Patient1(
    name: "Mike",
    surname: "Johnson",
    MEWs: 5,
    age: 15,
    gender: "Male",
    hn: "03",
    bedNumber: "C",
    ward: "C1",
    lastUpdate: DateTime.now().subtract(const Duration(hours: 3)),
    note: ["Detail X", "Detail Y"],
  ),
];

class PatientInSystem extends StatefulWidget {
  const PatientInSystem({super.key});

  @override
  _PatientInSystemState createState() => _PatientInSystemState();
}

class _PatientInSystemState extends State<PatientInSystem> {
  final List<bool> _isExpanded = [];
  final TextEditingController _searchController = TextEditingController();
  List<Patient1> _filteredPatients = _patients; // Initialize with all patients

  @override
  void initState() {
    super.initState();
    // Initialize all cards as collapsed
    _isExpanded.addAll(List<bool>.filled(_patients.length, false));

    // Listen to changes in the search query and update the filtered list
    _searchController.addListener(() {
      _filterPatients();
    });
  }

  // Method to filter the patients based on the search query
  void _filterPatients() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      _isExpanded.fillRange(0, _isExpanded.length, false);
      _filteredPatients = _patients.where((patient) {
        return "${patient.name.toLowerCase()} ${patient.surname.toLowerCase()})"
            .contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double screenWidth = size.width;
    final double screenHeight = size.height;
    SearchBarSetting sbs = SearchBarSetting(context: context);
    ButtonNextToSearchBarSetting btnsb =
        ButtonNextToSearchBarSetting(context: context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: sbs.getHeight(), // Search bar height
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: "${"search".tr()}...",
                          fillColor: const Color(
                              0xffCADBFF), // Set the background color
                          filled: true, // Enable background color
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(12), // Rounded corners
                            borderSide: BorderSide.none, // Remove border
                          ),
                          prefixIcon: const Icon(
                            FontAwesomeIcons.magnifyingGlass,
                            color: Colors.black,
                          ),
                          prefixIconConstraints: const BoxConstraints(
                            minWidth:
                                60, // Minimum width of the prefix icon container
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                      width: 15), // Space between search bar and button
                  ElevatedButton.icon(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const AddPatientForm();
                          });
                    },
                    icon: Icon(
                      FontAwesomeIcons.userPlus, // Your desired icon
                      color: Colors.white, // Icon color
                      size: screenWidth * 0.07, // Icon size
                    ),
                    label: Padding(
                      padding: const EdgeInsets.only(left: 4.0),
                      child: Text(
                        "addPatient".tr(),
                        style: const TextStyle(
                          color: Colors.white, // Text color
                          fontSize: 16, // Font size
                          fontWeight: FontWeight.bold, // Font weight
                        ),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color(0xff407BFF), // Background color
                      padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: btnsb.verticalPadding()), // Button padding
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(12), // Rounded corners
                      ),
                      elevation: 0, // Shadow depth
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: _filteredPatients.length,
                itemBuilder: (context, index) {
                  Patient1 patient = _filteredPatients[index];
                  String name = patient.name;
                  String surname = patient.surname;
                  String age = patient.age.toString();
                  String gender = patient.gender;
                  String hn = patient.hn;
                  String bedNum = patient.bedNumber;
                  String ward = patient.ward;
                  String MEWs = patient.MEWs.toString();
                  String time =
                      DateFormat('dd/MM/yyyy HH.mm').format(patient.lastUpdate);

                  return Padding(
                    padding:
                        const EdgeInsets.only(bottom: 16.0, left: 8, right: 8),
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
                                    _isExpanded[index] = !_isExpanded[index];
                                  });
                                },
                                child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 250),
                                    curve: Curves.easeInOut,
                                    padding: const EdgeInsets.only(top: 16),
                                    height: _isExpanded[index] ? 380 : 82,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: const Color(0xff98B1E8),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: _isExpanded[index]
                                        ? PatientIndData(
                                            age: age,
                                            gender: gender.tr(),
                                            hn: hn,
                                            bedNum: bedNum,
                                            ward: ward,
                                            MEWs: MEWs,
                                            time: time,
                                          )
                                        : const SizedBox()),
                              ),
                            ),
                          ),
                        ),

                        // Collapsed Header
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xffE0EAFF),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                bottom: 0, // Adjust the vertical position
                                right: 0, // Adjust the horizontal position
                                child: IgnorePointer(
                                  child: Image.asset(
                                    "assets/images/therapy3.png",
                                    // width: 100, // Adjust the image size
                                    // height: 100, // Adjust the image size
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          _isExpanded[index] =
                                              !_isExpanded[index];
                                        });
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "$name $surname",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                    shadows: [
                                                      Shadow(
                                                        color: Colors.black
                                                            .withOpacity(
                                                                0.25), // Shadow color with opacity
                                                        offset: const Offset(
                                                            0.8,
                                                            0.8), // Horizontal and vertical offset
                                                        blurRadius:
                                                            1, // Blur radius
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                RichText(
                                                    text: TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text:
                                                          "${"bedNumber".tr()} ",
                                                      style: const TextStyle(
                                                          fontSize: 11,
                                                          color: Colors.black),
                                                    ),
                                                    TextSpan(
                                                      text:
                                                          bedNum, // Another styled text
                                                      style: const TextStyle(
                                                          fontSize: 11,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black),
                                                    ),
                                                  ],
                                                )),
                                                Text(
                                                  "${"latestInspection".tr()} $time${"n".tr()}",
                                                  style: const TextStyle(
                                                      fontSize: 11),
                                                ),
                                                const SizedBox(height: 2),
                                              ],
                                            ),
                                          ),
                                          ToggleIconButton(func: () {}),
                                          const SizedBox(width: 8),
                                          buildActionButton(
                                            FontAwesomeIcons.clipboardList,
                                            () {
                                              showPatientDetails(
                                                  context, patient);
                                            },
                                            Colors.white,
                                            const Color(0xff3362CC),
                                          ),
                                          const SizedBox(width: 8),
                                          SizedBox(
                                            height: 30,
                                            child: OutlinedButton(
                                              onPressed: () {
                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return EditPatientForm(
                                                        name: name,
                                                        surname: surname,
                                                        age: age,
                                                        gender: gender,
                                                        hn: hn,
                                                        bedNum: bedNum,
                                                        ward: ward,
                                                      );
                                                    });
                                              },
                                              style: OutlinedButton.styleFrom(
                                                backgroundColor: Colors
                                                    .white, // White background
                                                side: const BorderSide(
                                                    color: Colors
                                                        .white), // Blue border
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8), // Rounded corners
                                                ),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 2,
                                                        vertical: 4), // Padding
                                              ),
                                              child: Text(
                                                "edit".tr(),
                                                style: const TextStyle(
                                                  color: Color(
                                                      0xff3362CC), // Blue text
                                                  fontSize: 16, // Font size
                                                  fontWeight: FontWeight
                                                      .bold, // Font weight
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        Positioned(
                          top: 69, // Adjust the position to fit your layout
                          left: size.width / 2.6,
                          child: Row(
                            children: [
                              InkWell(
                                child: Text("details".tr()),
                                onTap: () {
                                  setState(() {
                                    _isExpanded[index] = !_isExpanded[index];
                                  });
                                },
                              ), // This stays in place
                              Icon(
                                _isExpanded[index]
                                    ? Icons.expand_less
                                    : Icons.expand_more,
                              ),
                            ],
                          ),
                        ),

                        // Assess Text and Icon
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
