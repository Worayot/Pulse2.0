import 'package:flutter/material.dart';

void showResultDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.transparent, // Makes the background transparent
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Green background with emoji
            Container(
              color: Colors.green,
              child: Center(
                child: Text(
                  '😊', // Emoji inside the background
                  style: TextStyle(fontSize: 100),
                ),
              ),
            ),
            // White container with text
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(20),
              child: Text(
                'This is your custom dialog!',
                style: TextStyle(fontSize: 18, color: Colors.black),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      );
    },
  );
}
