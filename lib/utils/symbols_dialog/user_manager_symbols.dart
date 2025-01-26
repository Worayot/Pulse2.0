import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget userManagerSymbols() {
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
                const Text('• ',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const Icon(FontAwesomeIcons.personCirclePlus,
                    size: 16, color: Color(0xff3362CC)),
                Text('  ${'addUser'.tr()}',
                    style: const TextStyle(fontSize: 16))
              ],
            ),
            Row(
              children: [
                const Text('• ',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const Icon(FontAwesomeIcons.penClip,
                    size: 16, color: Color(0xff3362CC)),
                Text('  ${'editUserData'.tr()}',
                    style: const TextStyle(fontSize: 16))
              ],
            ),
            Row(
              children: [
                const Text('• ',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const Icon(FontAwesomeIcons.userMinus,
                    size: 16, color: Color(0xffE45B5B)),
                Text('  ${'deleteUser'.tr()}',
                    style: const TextStyle(fontSize: 16))
              ],
            ),
          ],
        ),
      ],
    ),
  );
}
