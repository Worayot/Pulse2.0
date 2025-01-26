import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget exportSymbols() {
  return Container(
    width: 400,
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
                const Text('• ',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const Icon(FontAwesomeIcons.filter,
                    size: 16, color: Color(0xff3362CC)),
                Text(' ${'filterData'.tr()}',
                    style: const TextStyle(fontSize: 16))
              ],
            ),
            Row(
              children: [
                const Text('• ',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const Icon(FontAwesomeIcons.fileExport,
                    size: 16, color: Color(0xff3362CC)),
                Text(' ${'nursing'.tr()}', style: const TextStyle(fontSize: 16))
              ],
            ),
          ],
        ),
      ],
    ),
  );
}
