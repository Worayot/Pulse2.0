import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pulse/utils/info_text_field.dart';

class EditUserForm extends StatefulWidget {
  const EditUserForm({super.key});

  @override
  State<EditUserForm> createState() => _EditUserFormState();
}

class _EditUserFormState extends State<EditUserForm> {
  final TextEditingController nameController =
      TextEditingController(text: "Worayot");
  final TextEditingController surnameController =
      TextEditingController(text: "Liamkaew");
  final TextEditingController positionController =
      TextEditingController(text: "Nurse");
  final TextEditingController nurseIDController =
      TextEditingController(text: "602");

  @override
  void dispose() {
    nameController.dispose();
    surnameController.dispose();
    positionController.dispose();
    nurseIDController.dispose();
    super.dispose();
  }

  void submitData() {
    String name = nameController.text.trim();
    String surname = surnameController.text.trim();
    String position = positionController.text.trim();
    String nurseID = nurseIDController.text.trim();

    if (name.isEmpty ||
        surname.isEmpty ||
        position.isEmpty ||
        nurseID.isEmpty) {
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
          height: size.height * 0.46,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 10, top: 10),
                child: Row(
                  children: [
                    Text(
                      "editUserData".tr(),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(
                        Icons.close,
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
                              minWidth: 140),
                        ),
                        SizedBox(
                          width: size.width / 2 - size.width / 8 - 6,
                          child: infoTextField(
                              title: "surname".tr(),
                              controller: surnameController,
                              boxColor: const Color(0xffE0EAFF),
                              minWidth: 140),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: infoTextField(
                          title: "position".tr(),
                          controller: positionController,
                          boxColor: const Color(0xffE0EAFF),
                          minWidth: 140),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: infoTextField(
                          title: "nurseID".tr(),
                          controller: nurseIDController,
                          boxColor: const Color(0xffE0EAFF),
                          minWidth: 140),
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
