import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pulse/utils/bulletPoints.dart';

class PatientInfo extends StatefulWidget {
  const PatientInfo({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PatientInfoState createState() => _PatientInfoState();
}

class _PatientInfoState extends State<PatientInfo> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.only(left: 0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Row(
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Row(
                        children: [
                          Icon(FontAwesomeIcons.angleLeft, size: 30),
                          SizedBox(width: 10)
                        ],
                      )),
                  Text(
                    "patientData".tr(),
                    textAlign: TextAlign.left,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 25),
              ExpandableWidget(title: "Patient's Data", widget: Container()),
              const SizedBox(height: 5),
              ExpandableWidget(title: "Inspection Time", widget: Container()),
              const SizedBox(height: 5),
              ExpandableWidget(title: "Full Report", widget: Container())
            ],
          ),
        ));
  }
}
