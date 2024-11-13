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
    String name = nameController.text;
    String surname = surnameController.text;
    String age = ageController.text;
    String ward = wardController.text;
    String hn = hnController.text;
    String bedNum = bedNumController.text;
    // Do something with the input, like print it or save it
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);

    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
              children: [
                SizedBox(
                  width: size.width / 2 - size.width / 8 - 6,
                  child: infoTextField(
                    title: "age".tr(),
                    controller: ageController,
                    boxColor: const Color(0xffE0EAFF),
                  ),
                ),
                SizedBox(
                  width: size.width / 2 - size.width / 8 - 6,
                  child: infoTextField(
                    // Make this a drop down later
                    title: "gender".tr(),
                    controller: nameController,
                    boxColor: const Color(0xffE0EAFF),
                  ),
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
              child: const Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }
}
