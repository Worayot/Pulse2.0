import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pulse/mainpage/home.dart';
import 'package:pulse/mainpage/patient_data/export.dart';
import 'package:pulse/mainpage/patient_data/patient.dart';
import 'package:pulse/mainpage/settings/setting.dart';
import 'package:pulse/utils/navbar.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // Single index to manage navigation
  int _selectedIndex = 0;

  // Different pages for each tab
  static List<Widget> _pages = <Widget>[
    NotificationPage(),
    PatientPage(),
    ExportPage(),
    SettingsPage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Getting screen size information
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    // Adjusting sizes based on screen width (responsive design)
    double iconSize =
        screenWidth * 0.06; // Relative icon size based on screen width
    double bottomBarHeight = screenHeight * 0.1; // Responsive bottom bar height

    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: CustomAnimatedBottomBar(
        selectedIndex: _selectedIndex, // Use the same selected index
        onItemSelected: _onItemTapped, // Handle item selection
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            icon: Icon(FontAwesomeIcons.house, size: iconSize),
            title: Text(
              'home'.tr(),
              style: TextStyle(
                  fontSize: screenWidth * 0.035), // Relative text size
            ),
            activeColor: const Color(0xffFEFEFE),
            inactiveColor: const Color(0xffC6D8FF),
          ),
          BottomNavyBarItem(
            icon: Icon(FontAwesomeIcons.users, size: iconSize),
            title: Text(
              'patient'.tr(),
              style: TextStyle(
                  fontSize: screenWidth * 0.035), // Relative text size
            ),
            activeColor: const Color(0xffFEFEFE),
            inactiveColor: const Color(0xffC6D8FF),
          ),
          BottomNavyBarItem(
            icon: Icon(FontAwesomeIcons.fileArrowDown, size: iconSize),
            title: Text(
              'data'.tr(),
              style: TextStyle(
                  fontSize: screenWidth * 0.035), // Relative text size
            ),
            activeColor: const Color(0xffFEFEFE),
            inactiveColor: const Color(0xffC6D8FF),
          ),
          BottomNavyBarItem(
            icon: Icon(FontAwesomeIcons.gear, size: iconSize),
            title: Text(
              'settings'.tr(),
              style: TextStyle(
                  fontSize: screenWidth * 0.035), // Relative text size
            ),
            activeColor: const Color(0xffFEFEFE),
            inactiveColor: const Color(0xffC6D8FF),
          ),
        ],
        height: bottomBarHeight, // Adjusting bottom bar height responsively
      ),
    );
  }
}
