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
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: CustomAnimatedBottomBar(
        selectedIndex: _selectedIndex, // Use the same selected index
        onItemSelected: _onItemTapped, // Handle item selection
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            icon: const Icon(FontAwesomeIcons.house, size: 20),
            title: Text('home'.tr()),
            activeColor: const Color(0xffFEFEFE),
            inactiveColor: const Color(0xffC6D8FF),
          ),
          BottomNavyBarItem(
            icon: const Icon(FontAwesomeIcons.users, size: 20),
            title: Text('patient'.tr()),
            activeColor: const Color(0xffFEFEFE),
            inactiveColor: const Color(0xffC6D8FF),
          ),
          BottomNavyBarItem(
            icon: const Icon(FontAwesomeIcons.fileArrowDown, size: 20),
            title: Text('data'.tr()),
            activeColor: const Color(0xffFEFEFE),
            inactiveColor: const Color(0xffC6D8FF),
          ),
          BottomNavyBarItem(
            icon: const Icon(FontAwesomeIcons.gear, size: 20),
            title: Text('settings'.tr()),
            activeColor: const Color(0xffFEFEFE),
            inactiveColor: const Color(0xffC6D8FF),
          ),
        ],
      ),
    );
  }
}
