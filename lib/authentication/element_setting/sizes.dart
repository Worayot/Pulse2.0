import 'package:flutter/material.dart';

Size getScreenSize(BuildContext context) {
  return MediaQuery.of(context).size;
}

double getPageTitleSize(BuildContext context) {
  return MediaQuery.of(context).size.width / 18.5;
}
