import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pulse/utils/bullet_points.dart';
import 'package:pulse/utils/info_box.dart';
import 'package:pulse/utils/inspection_time_row.dart';
import 'package:pulse/utils/report_widget.dart';

class PatientData extends StatefulWidget {
  const PatientData({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PatientDataState createState() => _PatientDataState();
}

class _PatientDataState extends State<PatientData> {
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
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const SizedBox(height: 25),
                ExpandableWidget(
                    title: "Patient's Data",
                    widget: Container(
                      padding: const EdgeInsets.only(top: 60),
                      height: 150,
                      decoration: BoxDecoration(
                        color: const Color(0xffE0EAFF), // Background color
                        borderRadius:
                            BorderRadius.circular(20), // Rounded corners
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              infoBox(
                                  title: "Name",
                                  content: "Worayot",
                                  boxColor: Colors.white),
                              infoBox(
                                  title: "Surname",
                                  content: "Liamkaew",
                                  boxColor: Colors.white)
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              infoBox(
                                  title: "Age",
                                  content: "21",
                                  boxColor: Colors.white),
                              infoBox(
                                  title: "Gender",
                                  content: "Male",
                                  boxColor: Colors.white)
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              infoBox(
                                  title: "Hospital no.",
                                  content: "C11",
                                  boxColor: Colors.white),
                              infoBox(
                                  title: "Bed No.",
                                  content: "602",
                                  boxColor: Colors.white)
                            ],
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 22.0),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Ward",
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.white, // Background color
                                      borderRadius: BorderRadius.circular(
                                          12), // Rounded corners
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.all(
                                          10.0), // Optional padding inside the container
                                      child: Text(
                                        "Thammasat",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                  ),
                                  description(),
                                ]),
                          )
                        ],
                      ),
                    ),
                    box_height: 450,
                    image: "assets/images/bullet1.png"),
                const SizedBox(height: 10),
                const ExpandableWidget(
                    title: "Inspection Time",
                    widget: Column(children: [
                      SizedBox(height: 60),
                      InspectionTimeRow(time: "9:30"),
                      InspectionTimeRow(time: "9:45"),
                      InspectionTimeRow(time: "10:00")
                    ]),
                    box_height: 220,
                    image: "assets/images/bullet2.png"),
                const SizedBox(height: 10),
                const ExpandableWidget(
                    title: "Full Report",
                    widget: Column(
                      children: [
                        SizedBox(height: 70),
                        ReportWidget(tableHeight: 350)
                      ],
                    ),
                    box_height: 520,
                    image: "assets/images/bullet3.png")
              ],
            ),
          ),
        ));
  }

  Widget description() {
    return const Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 20.0),
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("เวลาที่ตรวจล่าสุด ",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text("12/11/2467 15.00 น.", style: TextStyle()),
              ],
            ),
          ),
        ),
        Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("คะแนน MEWs​ โดยรวมล่าสุด ",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text("4",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ],
    );
  }
}
