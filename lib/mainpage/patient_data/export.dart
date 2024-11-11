import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pulse/utils/actionButton.dart';

class ExportPage extends StatefulWidget {
  @override
  _ExportPageState createState() => _ExportPageState();
}

class Patient {
  final String name;
  final String surname;
  final int age;
  final String gender;
  final String ward;
  final String hospitalNumber;
  final String bedNumber;

  Patient({
    required this.name,
    required this.surname,
    required this.age,
    required this.gender,
    required this.ward,
    required this.hospitalNumber,
    required this.bedNumber,
  });
}

class _ExportPageState extends State<ExportPage> {
  final List<Patient> _patients = [
    Patient(
        name: "John",
        surname: "Doe",
        age: 30,
        gender: "Male",
        ward: "A1",
        hospitalNumber: "H123",
        bedNumber: "B1"),
    Patient(
        name: "Jane",
        surname: "Smith",
        age: 25,
        gender: "Female",
        ward: "A2",
        hospitalNumber: "H124",
        bedNumber: "B2"),
    Patient(
        name: "Mike",
        surname: "Johnson",
        age: 40,
        gender: "Male",
        ward: "B1",
        hospitalNumber: "H125",
        bedNumber: "B3"),
    Patient(
        name: "Jane",
        surname: "Johnson",
        age: 40,
        gender: "Female",
        ward: "B1",
        hospitalNumber: "H125",
        bedNumber: "B3"),
    Patient(
        name: "Worayot",
        surname: "Liamkaew",
        age: 21,
        gender: "Male",
        ward: "C11",
        hospitalNumber: "602",
        bedNumber: "01"),
    // Add more patients as needed
  ];

  List<Patient> _filteredPatients = [];
  String _nameFilter = '';
  String _surnameFilter = '';
  String _wardFilter = '';
  String _genderFilter = '';
  String _hnFilter = '';
  String _bedNumFilter = '';
  double _minAge = 0;
  double _maxAge = 120;

  @override
  void initState() {
    super.initState();
    _filteredPatients = _patients; // Initialize with all patients
  }

  void _filterPatients() {
    setState(() {
      _filteredPatients = _patients.where((patient) {
        final matchesName = _nameFilter.isEmpty ||
            patient.name.toLowerCase().contains(_nameFilter.toLowerCase());
        final matchesSurname = _surnameFilter.isEmpty ||
            patient.surname
                .toLowerCase()
                .contains(_surnameFilter.toLowerCase());
        final matchesWard = _wardFilter.isEmpty ||
            patient.ward.toLowerCase().contains(_wardFilter.toLowerCase());
        final matchesGender = _genderFilter.isEmpty ||
            patient.gender.toLowerCase().contains(_genderFilter.toLowerCase());
        final matchesHospitalNumber = _hnFilter.isEmpty ||
            patient.hospitalNumber
                .toLowerCase()
                .contains(_hnFilter.toLowerCase());
        final matchesBedNumber = _bedNumFilter.isEmpty ||
            patient.bedNumber
                .toLowerCase()
                .contains(_bedNumFilter.toLowerCase());
        final matchesAge =
            patient.age >= _minAge && patient.age <= _maxAge; // Age filter

        return matchesName &&
            matchesSurname &&
            matchesWard &&
            matchesGender &&
            matchesHospitalNumber &&
            matchesBedNumber &&
            matchesAge; // Include age filter in the return
      }).toList();
    });
  }

  void _resetFilters() {
    setState(() {
      _nameFilter = '';
      _surnameFilter = '';
      _wardFilter = '';
      _genderFilter = '';
      _hnFilter = '';
      _bedNumFilter = '';
      _minAge = 0;
      _maxAge = 120;
      _filteredPatients = _patients; // Reset to original patient list
    });
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            width: 400, // Set the desired width here
            padding: EdgeInsets.all(16.0), // Optional: add padding
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Filter Patients',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16.0),
                _buildFilterInputs(),
                const SizedBox(height: 16.0),
                StatefulBuilder(
                  builder: (context, setState) {
                    return _buildAgeSlider(setState);
                  },
                ),
                const SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Close the dialog
                      },
                      child: Text('Close'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _filterPatients(); // Apply filters
                        Navigator.of(context).pop(); // Close the dialog
                      },
                      child: Text('Apply Filters'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildFilterInputs() {
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(labelText: 'Filter by Name'),
          onChanged: (value) {
            _nameFilter = value;
            _filterPatients(); // Apply filter immediately
          },
        ),
        TextField(
          decoration: InputDecoration(labelText: 'Filter by Surname'),
          onChanged: (value) {
            _surnameFilter = value;
            _filterPatients();
          },
        ),
        TextField(
          decoration: InputDecoration(labelText: 'Filter by Gender'),
          onChanged: (value) {
            _genderFilter = value;
            _filterPatients(); // Apply filter immediately
          },
        ),
        TextField(
          decoration: InputDecoration(labelText: 'Filter by Ward'),
          onChanged: (value) {
            _wardFilter = value;
            _filterPatients(); // Apply filter immediately
          },
        ),
        TextField(
          decoration: InputDecoration(labelText: 'Filter by Hospital number'),
          onChanged: (value) {
            _hnFilter = value;
            _filterPatients(); // Apply filter immediately
          },
        ),
        TextField(
          decoration: InputDecoration(labelText: 'Filter by Bed number'),
          onChanged: (value) {
            _bedNumFilter = value;
            _filterPatients(); // Apply filter immediately
          },
        ),
      ],
    );
  }

  Widget _buildAgeSlider(StateSetter setState) {
    return Column(
      children: [
        Text('Filter by Age: ${_minAge.toInt()} - ${_maxAge.toInt()}'),
        RangeSlider(
          values: RangeValues(_minAge, _maxAge),
          min: 0,
          max: 120,
          divisions: 120,
          labels: RangeLabels('${_minAge.toInt()}', '${_maxAge.toInt()}'),
          onChanged: (values) {
            setState(() {
              _minAge = values.start;
              _maxAge = values.end;
            });
          },
        ),
      ],
    );
  }

  Widget _buildPatientList() {
    return ListView.builder(
      itemCount: _filteredPatients.length,
      itemBuilder: (context, index) {
        final patient = _filteredPatients[index];
        return Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16),
          child: Stack(
            children: [
              Card(
                color: const Color(0xffE0EAFF),
                margin:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text('${patient.name} ${patient.surname}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18)),
                                SizedBox(width: 5),
                                if (patient.gender == "Male")
                                  Icon(
                                    Icons.male, // For male
                                    color: Colors.blue,
                                    size: 28.0,
                                  ),
                                if (patient.gender == "Female")
                                  Icon(
                                    Icons.female, // For female
                                    color: Colors.pink,
                                    size: 28.0,
                                  ),
                                Text(
                                    " (${patient.age} ${"years".tr()}${"old".tr()})",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold))
                              ],
                            ),
                            Row(
                              children: [
                                Text('${"ward".tr()} '),
                                Text(patient.ward,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold)),
                                Text(' ${"bedNo".tr()} '),
                                Text(patient.bedNumber,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                            Row(
                              children: [
                                Text('${"hnNo".tr()} '),
                                Text(patient.hospitalNumber,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ],
                        ),
                      ),
                      buildExportButton(FontAwesomeIcons.fileExport, () {},
                          Colors.white, const Color(0xff4B74D1))
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 0,
                right: 20,
                bottom: 0,
                child: ClipRect(
                  child: SizedBox(
                    height: 65,
                    width: 200,
                    child: Opacity(
                      opacity: 0.25, // Set the opacity to 50%
                      child: Image.asset(
                        'assets/images/therapy4.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                  top: 0,
                  bottom: 0,
                  right: 25,
                  child: buildExportButton(FontAwesomeIcons.fileExport, () {},
                      Colors.white, const Color(0xff4B74D1))),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Export Patients'),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: _showFilterDialog, // Show filter dialog on button press
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(child: _buildPatientList()),
          Padding(
            padding: const EdgeInsets.only(right: 16.0, bottom: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Reset Filters button with icon
                ElevatedButton.icon(
                  onPressed: _resetFilters, // Reset filters button
                  icon:
                      Icon(Icons.refresh), // Icon for the Reset Filters button
                  label: Text(
                      'Reset Filters'), // Text for the Reset Filters button
                ),
                SizedBox(width: 10),
                // Export All button with icon
                ElevatedButton.icon(
                  onPressed: _exportAll, // Export all button
                  icon: Icon(
                      Icons.file_download), // Icon for the Export All button
                  label: Text('Export All'), // Text for the Export All button
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void _exportAll() {}
