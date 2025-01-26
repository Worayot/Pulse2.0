import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget _buildNoteEditor(BuildContext context) {
  return Stack(
    children: [
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xffC6D8FF),
          borderRadius: BorderRadius.circular(15),
        ),
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxHeight: 100, // Adjust the max height as needed
          ),
          child: Scrollbar(
            thumbVisibility: true, // Show scrollbar for better UX
            child: SingleChildScrollView(
              child: TextField(
                maxLines: null, // Allows for multi-line input
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  hintText: '',
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.grey.shade700),
                ),
                style: TextStyle(
                  color: Colors.grey.shade800,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
      ),
      Positioned(
        top: -5,
        right: -5,
        child: IconButton(
          icon: Icon(
            FontAwesomeIcons.solidPenToSquare,
            color: Colors.blue.shade800,
            size: 24,
          ),
          onPressed: () {
            // Define the action when the icon is pressed
          },
        ),
      ),
    ],
  );
}
