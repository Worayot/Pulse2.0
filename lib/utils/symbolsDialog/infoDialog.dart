import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pulse/utils/symbolsDialog/homeSymbols.dart';

void showInfoDialog(BuildContext context, Widget widget) {
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
                  left: 30,
                  right: 30,
                  bottom: 30), // Remove the default padding
              content: widget));
    },
  );
}
