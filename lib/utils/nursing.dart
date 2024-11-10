import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void showNursing(BuildContext context, String MEWs) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.only(bottom: 0),
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15), // Adjust radius here
            ),
            title: Row(
              children: [
                Text(
                  "nursing".tr(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(
                    FontAwesomeIcons.xmark, // The icon to display
                    color: Colors.black, // Icon color
                    size: 30, // Icon size
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
            contentPadding:
                const EdgeInsets.only(left: 30, right: 30, bottom: 30),
            content: Column(
              children: [
                buildNursingDetails(MEWs),
              ],
            ),
          ),
        ));
      });
}

Widget buildNursingDetails(String MEWs) {
  // Process MEWs
  String nursing = "";
  int? _MEWs = int.parse(MEWs);
  if (_MEWs <= 1) {
    nursing = "nursingLow".tr();
  } else if (_MEWs == 2) {
    nursing = "nursingLowMedium".tr();
  } else if (_MEWs == 3) {
    nursing = "nursingMedium".tr();
  } else if (_MEWs == 4) {
    nursing = "nursingMediumHigh".tr();
  } else if (_MEWs >= 5) {
    nursing = "nursingHigh".tr();
  }

  return SizedBox(
    width: 260,
    child: Column(
      children: [
        const SizedBox(height: 25),
        Row(
          children: [
            Text(
              "${"latestMEWs".tr()} : ",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(
                  MEWs,
                  style: const TextStyle(
                      fontSize: 40, fontWeight: FontWeight.bold),
                )),
          ],
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            nursing,
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.left,
            softWrap: true,
          ),
        ),
      ],
    ),
  );
}
