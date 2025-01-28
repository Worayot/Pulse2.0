import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDataProvider extends ChangeNotifier {
  String _name = 'Default Name';
  String _nurseID = '';

  String get name => _name;
  String get nurseID => _nurseID;

  // Load user data from SharedPreferences
  Future<void> loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _name = prefs.getString('name') ?? 'Default Name';
    _nurseID = prefs.getString('nurseID') ?? '';
    notifyListeners(); // Notify listeners after data is loaded
  }

  // Update user data in SharedPreferences
  Future<void> updateUserData(String name, String nurseID) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', name);
    await prefs.setString('nurseID', nurseID);
    await loadUserData(); // Reload data and notify listeners
  }

  // Save a boolean preference and notify listeners
  Future<void> savePreference(String key, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value); // Save the boolean value
    notifyListeners(); // Notify listeners that preference has changed
  }
}
