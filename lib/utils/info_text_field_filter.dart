import 'package:flutter/material.dart';

Widget infoTextField(
    {required String title,
    required TextEditingController controller,
    required Color boxColor,
    required BuildContext context,
    required bool fillSpace}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          textAlign: TextAlign.left,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      const SizedBox(height: 5),
      Container(
        // Remove fixed width and let it take available space
        width:
            fillSpace ? double.infinity : MediaQuery.of(context).size.width / 3,
        height: 40,
        decoration: BoxDecoration(
          color: boxColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding:
              const EdgeInsets.only(top: 10, bottom: 0, left: 12, right: 12),
          child: TextFormField(
            controller: controller,
            maxLines: 2, // Allows for text wrapping to new lines
            style: const TextStyle(color: Colors.black, fontSize: 14),
            decoration: const InputDecoration(
              border: InputBorder.none,
              isCollapsed: true, // Reduce padding inside the text field
            ),
          ),
        ),
      ),
    ],
  );
}