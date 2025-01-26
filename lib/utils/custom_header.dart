import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget header() {
  return const Padding(
    padding: EdgeInsets.only(left: 10.0),
    child: Row(
      children: [
        CircleAvatar(
          radius: 28,
          child: Text(
            'ว', // First letter of the user's name
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'วรยศ เลี่ยมแก้ว', // Full name
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'เลขพยาบาล : 112203', // User ID
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ],
    ),
  );
}
