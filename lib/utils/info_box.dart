import 'package:flutter/material.dart';

Widget infoBox({
  required String title,
  required String content,
  required Color boxColor,
}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start, // Aligns text to the left
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            textAlign: TextAlign.left,
          ),
        ),
        const SizedBox(height: 5),
        Container(
          width: 150,
          decoration: BoxDecoration(
            color: boxColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              content,
              style: const TextStyle(color: Colors.black),
            ),
          ),
        ),
      ],
    ),
  );
}
