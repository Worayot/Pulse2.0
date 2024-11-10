import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void _showTimeManager(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 0),
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15), // Adjust radius here
            ),
            title: Row(
              children: [
                Text(
                  "notifications".tr(),
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
            content: const Row(
              children: [],
            ),
          ),
        );
      });
}
