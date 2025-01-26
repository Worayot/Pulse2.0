import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pulse/utils/patient_list_home.dart';
import 'package:pulse/utils/report_widget.dart';

void showPatientDetails(BuildContext context, Patient1 patient) {
  List<String> date =
      DateFormat('HH:mm dd/MM/yyyy').format(patient.lastUpdate).split(" ");

  final screenWidth = MediaQuery.of(context).size.width;
  final screenHeight = MediaQuery.of(context).size.height;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(screenWidth * 0.04),
        ),
        title: Row(
          children: [
            Text(
              'details'.tr(),
              style: TextStyle(
                fontSize: screenWidth * 0.05,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            IconButton(
              icon: Icon(
                FontAwesomeIcons.xmark,
                color: Colors.black,
                size: screenWidth * 0.06,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
        contentPadding: EdgeInsets.zero,
        content: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Opacity(
                opacity: 0.8,
                child: Image.asset(
                  "assets/images/therapy.png",
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.08,
                vertical: screenHeight * 0.02,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: screenHeight * 0.02),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: " ${patient.name} ${patient.surname}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: screenWidth * 0.05,
                                ),
                              ),
                              TextSpan(
                                text: " (${patient.age} ${"yrs".tr()})\n",
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: screenWidth * 0.045,
                                ),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "hn".tr(),
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: screenWidth * 0.045,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "${"bedNumber".tr()}: ${patient.bedNumber} ${"ward".tr()}: ${patient.ward}",
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: screenWidth * 0.045,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "${"latestInspection".tr()} ${date[0]} ${"oClock".tr()} ${date[1]}",
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: screenWidth * 0.045,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "overallMEWS".tr(),
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: screenWidth * 0.045,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "${patient.MEWs}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: screenWidth * 0.12,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: screenHeight * 0.35,
                          child: ReportWidget(tableHeight: screenHeight / 4),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}
