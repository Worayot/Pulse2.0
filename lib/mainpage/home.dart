// ignore_for_file: no_leading_underscores_for_local_identifiers, non_constant_identifier_names

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pulse/utils/infoDialog.dart';
import 'package:pulse/utils/patientList.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  // List of GlobalKeys for expanded content

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
            padding: const EdgeInsets.only(left: 30, top: 30),
            child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "home".tr(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ))),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 25, top: 23),
            child: IconButton(
              icon: const FaIcon(FontAwesomeIcons.circleInfo,
                  size: 25, // Size of the icon
                  color: Color(0xff3362CC) // Color of the icon
                  ),
              onPressed: () {
                showInfoDialog(context);
              },
            ),
          ),
        ],
      ),
      body: const Padding(
        padding: EdgeInsets.only(top: 16, left: 16, right: 16),
        child: Column(
          children: [SizedBox(height: 20), PatientList()],
        ),
      ),
    );
  }
}
