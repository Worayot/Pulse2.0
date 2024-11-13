import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pulse/utils/infoTextField.dart';

class AddPatientForm extends StatefulWidget {
  const AddPatientForm({super.key});

  @override
  State<AddPatientForm> createState() => _AddPatientFormState();
}

class _AddPatientFormState extends State<AddPatientForm> {
  // Step 1: Initialize a TextEditingController
  // final TextEditingController _nameController = // For update Patient
  //     TextEditingController(text: "Editable Content");

  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController wardController = TextEditingController();
  final TextEditingController hnController = TextEditingController();
  final TextEditingController bedNumController = TextEditingController();

  String? _selectedGender;

  @override
  void dispose() {
    nameController.dispose(); // Dispose the controller when done
    surnameController.dispose();
    ageController.dispose();
    wardController.dispose();
    hnController.dispose();
    bedNumController.dispose();
    super.dispose();
  }

  void submitData() {
    String name = nameController.text.trim();
    String surname = surnameController.text.trim();
    String age = ageController.text.trim();
    String ward = wardController.text.trim();
    String hn = hnController.text.trim();
    String bedNum = bedNumController.text.trim();

    if (name.isEmpty ||
        surname.isEmpty ||
        age.isEmpty ||
        ward.isEmpty ||
        hn.isEmpty ||
        bedNum.isEmpty ||
        _selectedGender == null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Warning".tr()),
            content: Text("plsFillInAllTheFields".tr()),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true); // User confirmed
                },
                child: Text("ok".tr()),
              ),
            ],
          );
        },
      );
      return;
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);

    return Dialog(
      // insetPadding: EdgeInsets.all(19),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(
                  width: size.width / 2 - size.width / 8 - 6,
                  child: infoTextField(
                    title: "name".tr(),
                    controller: nameController,
                    boxColor: const Color(0xffE0EAFF),
                  ),
                ),
                SizedBox(
                  width: size.width / 2 - size.width / 8 - 6,
                  child: infoTextField(
                    title: "surname".tr(),
                    controller: surnameController,
                    boxColor: const Color(0xffE0EAFF),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: size.width / 2 - size.width / 8 - 6,
                  child: infoTextField(
                    title: "age".tr(),
                    controller: ageController,
                    boxColor: const Color(0xffE0EAFF),
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text("gender".tr(),
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 3),
                    SizedBox(
                      width: size.width / 2 - size.width / 8 - 23,
                      height: 40,
                      child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xffE0EAFF),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(12), // Rounded corners
                            borderSide:
                                BorderSide.none, // Removes visible border line
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        value: _selectedGender,
                        items: [
                          DropdownMenuItem(
                            value: "Male",
                            child: Text("male".tr()),
                          ),
                          DropdownMenuItem(
                            value: "Female",
                            child: Text("female".tr()),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _selectedGender = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: size.width / 2 - size.width / 8 - 6,
                  child: infoTextField(
                    title: "hnNo".tr(),
                    controller: hnController,
                    boxColor: const Color(0xffE0EAFF),
                  ),
                ),
                SizedBox(
                  width: size.width / 2 - size.width / 8 - 6,
                  child: infoTextField(
                    title: "bedNumber".tr(),
                    controller: bedNumController,
                    boxColor: const Color(0xffE0EAFF),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: double.infinity,
              child: infoTextField(
                  title: "ward".tr(),
                  controller: wardController,
                  boxColor: const Color(0xffE0EAFF)),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: submitData, // Step 4: Trigger to use the data
              child: const Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}
