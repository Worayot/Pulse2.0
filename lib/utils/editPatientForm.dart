import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pulse/utils/genderDropdown.dart';
import 'package:pulse/utils/infoTextField.dart';

class EditPatientForm extends StatefulWidget {
  const EditPatientForm({super.key});

  @override
  State<EditPatientForm> createState() => _EditPatientFormState();
}

class _EditPatientFormState extends State<EditPatientForm> {
  final TextEditingController nameController =
      TextEditingController(text: "Chicky");
  final TextEditingController surnameController =
      TextEditingController(text: "Chicken");
  final TextEditingController ageController = TextEditingController(text: "10");
  final TextEditingController wardController =
      TextEditingController(text: "C11");
  final TextEditingController hnController = TextEditingController(text: "602");
  final TextEditingController bedNumController =
      TextEditingController(text: "Bedroom");

  String? _selectedGender = "Male";

  @override
  void dispose() {
    nameController.dispose();
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
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(15),
        ),
        child: SizedBox(
          height: 475,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 10, top: 10),
                child: Row(
                  children: [
                    Text(
                      "editPatientData".tr(),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(
                        FontAwesomeIcons.xmark,
                        color: Colors.black,
                        size: 30,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ),
              Padding(
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
                        GenderDropdown(
                          size: size,
                          selectedGender: _selectedGender,
                          onGenderChanged: (value) {
                            setState(() {
                              _selectedGender = value;
                            });
                          },
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
                        boxColor: const Color(0xffE0EAFF),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton.icon(
                        onPressed: submitData,
                        label: Text('save'.tr(),
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff407BFF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  12), // Set border radius
                            ),
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}