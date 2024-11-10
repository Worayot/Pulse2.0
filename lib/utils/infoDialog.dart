import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void showInfoDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Padding(
          padding: const EdgeInsets.only(bottom: 300),
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15), // Adjust radius here
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const FaIcon(
                      FontAwesomeIcons.circleInfo,
                      size: 25, // Size of the icon
                      color: Color(0xff3362CC), // Color of the icon
                    ),
                    const SizedBox(width: 10),
                    Text('symbolDescription'.tr(),
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                  ],
                ),
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
            contentPadding: const EdgeInsets.only(
                left: 30, right: 30, bottom: 30), // Remove the default padding
            content: Container(
              width: 800,
              constraints: const BoxConstraints(
                maxHeight: 180,
              ),
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  Column(
                    children: [
                      Row(
                        children: [
                          const Text('•',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
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
                              style: const TextStyle(fontSize: 16)),
                        ],
                      ),
                      Row(
                        children: [
                          Text('\t\t${'MEWsScreen'.tr()}',
                              style: const TextStyle(fontSize: 16))
                        ],
                      ),
                      Row(
                        children: [
                          const Text('• ',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          const Icon(FontAwesomeIcons.solidClock,
                              size: 16, color: Color(0xff3362CC)),
                          Text(' ${'manageNotify'.tr()}',
                              style: const TextStyle(fontSize: 16))
                        ],
                      ),
                      Row(
                        children: [
                          const Text('• ',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          const Icon(FontAwesomeIcons.userNurse,
                              size: 16, color: Color(0xff3362CC)),
                          Text(' ${'nursing'.tr()}',
                              style: const TextStyle(fontSize: 16))
                        ],
                      ),
                      Row(
                        children: [
                          const Text('• ',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
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
            ),
          ));
    },
  );
}
