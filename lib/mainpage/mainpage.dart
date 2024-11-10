import 'package:flutter/material.dart';
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
      bottomNavigationBar: MainNavigationBar(
        selectedIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
