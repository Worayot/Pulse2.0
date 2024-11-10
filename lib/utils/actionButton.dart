import 'package:flutter/material.dart';

Widget buildActionButton(IconData icon) {
  return SizedBox(
    width: 40,
    height: 40,
    child: ElevatedButton(
      onPressed: () {
        // Your onPressed action here
      },
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        backgroundColor: Colors.white,
        padding: const EdgeInsets.all(8),
      ),
      child: Icon(icon, size: 20, color: const Color(0xff4B74D1)),
    ),
  );
}
