import 'package:flutter/material.dart';

class CircleWithNumber extends StatelessWidget {
  final int number; // The number to be displayed in the circle
  final Color color; // The color of the circle

  // Constructor for initializing the number and color
  const CircleWithNumber({
    required this.number,
    required this.color,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50, // Circle width
      height: 50, // Circle height
      decoration: BoxDecoration(
        color: color, // Background color of the circle
        shape: BoxShape.circle, // Making the container circular
      ),
      child: Center(
        child: Text(
          '$number', // Displaying the number
          style: const TextStyle(
            color: Colors.white, // White color for the text
            fontSize: 22, // Font size for the number
            fontWeight: FontWeight.bold, // Bold number
          ),
        ),
      ),
    );
  }
}
