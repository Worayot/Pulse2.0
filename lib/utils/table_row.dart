import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pulse/func/get_color.dart';
import 'package:pulse/utils/mews_forms.dart';
import 'package:pulse/utils/note_editor.dart';

class TableRowWidget extends StatelessWidget {
  final dynamic MEWs;
  final String time;
  // Constructor with required parameters
  const TableRowWidget({
    Key? key,
    required this.MEWs,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10, top: 8),
      child: Row(
        children: [
          Container(
            // padding: padding,
            width: 55,
            height: 26,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
                  BorderRadius.circular(4), // Rounded corners (optional)
            ),
            child: Center(
              child: Text(
                '$time${"n".tr()}',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      color: Colors.black
                          .withOpacity(0.25), // Shadow color with opacity
                      offset: const Offset(
                          0.8, 0.8), // Horizontal and vertical offset
                      blurRadius: 1, // Blur radius
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            height: 30,
            width: 125,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: const Color(0xff3362CC), // Text color
                backgroundColor: const Color(0xffE0EAFF), // Background color
                shadowColor: Colors.transparent, // Removes shadow
                side: const BorderSide(
                  color: Color(0xff3362CC), // Border color
                  width: 1, // Border width
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4), // Rounded corners
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              ),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const MEWsForms();
                    });
              },
              child: Text(
                "assessScore".tr(),
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            // padding: padding,
            width: 75,
            height: 26,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
                  BorderRadius.circular(4), // Rounded corners (optional)
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'MEWS : ',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          color: Colors.black
                              .withOpacity(0.25), // Shadow color with opacity
                          offset: const Offset(
                              0.8, 0.8), // Horizontal and vertical offset
                          blurRadius: 1, // Blur radius
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '$MEWs',
                    style: TextStyle(
                      color: getColor(MEWs),
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          color: Colors.black
                              .withOpacity(0.2), // Shadow color with opacity
                          offset: const Offset(
                              0.8, 0.8), // Horizontal and vertical offset
                          blurRadius: 1, // Blur radius
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            height: 30,
            width: 70,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: const Color(0xff3362CC), // Text color
                backgroundColor: const Color(0xffE0EAFF), // Background color
                shadowColor: Colors.transparent, // Removes shadow
                side: const BorderSide(
                  color: Color(0xff3362CC), // Border color
                  width: 1, // Border width
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4), // Rounded corners
                ),
                padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 0),
              ),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return NoteEditor(
                        onSave: () {},
                      );
                    });
              },
              child: Text(
                "note".tr(),
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}