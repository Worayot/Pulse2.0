import 'package:flutter/material.dart';

Color getColor(int num) {
  if (num == 1 || num == 2) {
    return Colors.green;
  } else if (num == 3) {
    return Colors.yellow.shade700;
  } else if (num == 4) {
    return Colors.orange;
  } else {
    return Colors.red;
  }
}
