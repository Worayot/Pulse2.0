import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pulse/utils/DateNavigation.dart';
import 'package:pulse/utils/patientListHome.dart';
import 'package:pulse/utils/swipableTable.dart';
import 'package:pulse/utils/reportWidget.dart';

void showPatientDetails(BuildContext context, Patient patient) {
  List<String> date =
      DateFormat('HH:mm dd/MM/yyyy').format(patient.lastUpdate).split(" ");

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: Row(
          children: [
            Text(
              'details'.tr(),
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            IconButton(
              icon: const Icon(FontAwesomeIcons.xmark,
                  color: Colors.black, size: 30),
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
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 20),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: " ${patient.name} ${patient.surname}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              TextSpan(
                                text: "(${patient.age} ${"years".tr()})\n",
                                style: const TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "hn".tr(),
                          style: const TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 18),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "${"bedNumber".tr()}: ${patient.bedNumber} ${"ward".tr()}: ${patient.ward}",
                          style: const TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 18),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "${"latestInspection".tr()} ${date[0]} ${"oClock".tr()} ${date[1]}",
                          style: const TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 18),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "overallMEWS".tr(),
                          style: const TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 18),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "${patient.MEWs}",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 50),
                          textAlign: TextAlign.center,
                        ),
                        const ReportWidget(tableHeight: 250)
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
