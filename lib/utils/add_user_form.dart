import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pulse/authentication/universal_setting/sizes.dart';
import 'package:pulse/utils/info_text_field.dart';

class AddUserForm extends StatefulWidget {
  const AddUserForm({super.key});

  @override
  State<AddUserForm> createState() => _AddUserFormState();
}

class _AddUserFormState extends State<AddUserForm> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController roleController = TextEditingController();
  final TextEditingController nurseIDController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    surnameController.dispose();
    roleController.dispose();
    nurseIDController.dispose();
    super.dispose();
  }

  void submitData() {
    String name = nameController.text.trim();
    String surname = surnameController.text.trim();
    String role = roleController.text.trim();
    String nurseID = nurseIDController.text.trim();

    if (name.isEmpty || surname.isEmpty || role.isEmpty || nurseID.isEmpty) {
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
    TextWidgetSize tws = TextWidgetSize(context: context);
    return Dialog(
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(15),
        ),
        child: SizedBox(
          height: size.height * 0.58,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 10, top: 10),
                child: Row(
                  children: [
                    Text(
                      "addUserData".tr(),
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
                        Expanded(
                          child: SizedBox(
                            child: infoTextField(
                                fontSize: tws.getInfoBoxTextSize(),
                                title: "name".tr(),
                                controller: nameController,
                                boxColor: const Color(0xffE0EAFF),
                                minWidth: 140,
                                hintText: "fillInName".tr()),
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                            child: infoTextField(
                                title: "surname".tr(),
                                fontSize: tws.getInfoBoxTextSize(),
                                controller: surnameController,
                                boxColor: const Color(0xffE0EAFF),
                                minWidth: 140,
                                hintText: "fillInSurname".tr()),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: infoTextField(
                          title: "role".tr(),
                          fontSize: tws.getInfoBoxTextSize(),
                          controller: roleController,
                          boxColor: const Color(0xffE0EAFF),
                          minWidth: 140,
                          hintText: "fillInRole".tr()),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: infoTextField(
                          title: "nurseID".tr(),
                          fontSize: tws.getInfoBoxTextSize(),
                          controller: nurseIDController,
                          boxColor: const Color(0xffE0EAFF),
                          minWidth: 140,
                          hintText: "fillInNurseID".tr()),
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
