import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget homeSymbols() {
  return Container(
    width: 800,
    constraints: const BoxConstraints(
      maxHeight: 210,
    ),
    child: Column(
      children: [
        const SizedBox(height: 30),
        Column(
          children: [
            Row(
              children: [
                const Text('•',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Text(
                  ' ${'clicking'.tr()}',
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  ' ${'patientName'.tr()}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(' ${'willGoToMEWsCalScreen'.tr()}',
                    style: const TextStyle(fontSize: 16), softWrap: true),
              ],
            ),
            Row(
              children: [
                Text('\t\t${'MEWsCalScreen'.tr()}',
                    style: const TextStyle(fontSize: 16))
              ],
            ),
            Row(
              children: [
                const Text('• ',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const Icon(FontAwesomeIcons.solidClock,
                    size: 16, color: Color(0xff3362CC)),
                Text(' ${'manageNotify'.tr()}',
                    style: const TextStyle(fontSize: 16))
              ],
            ),
            Row(
              children: [
                const Text('• ',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const Icon(FontAwesomeIcons.userNurse,
                    size: 16, color: Color(0xff3362CC)),
                Text(' ${'nursing'.tr()}', style: const TextStyle(fontSize: 16))
              ],
            ),
            Row(
              children: [
                const Text('• ',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const Icon(FontAwesomeIcons.clipboardList,
                    size: 16, color: Color(0xff3362CC)),
                Text(' ${'patientDetails'.tr()}',
                    style: const TextStyle(fontSize: 16))
              ],
            ),
            Row(
              children: [
                const Text('• ',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: Container(
                    width: 17,
                    height: 17,
                    decoration: const BoxDecoration(
                      color: Colors.red, // Background color
                      shape: BoxShape.circle, // Make it circular
                    ),
                    child: const Icon(
                      FontAwesomeIcons.xmark,
                      size: 15,
                      color: Colors.white, // Icon color
                    ),
                  ),
                ),
                Text(' ${'deletePatientInCare'.tr()}',
                    style: const TextStyle(fontSize: 16))
              ],
            ),
          ],
        ),
      ],
    ),
  );
}