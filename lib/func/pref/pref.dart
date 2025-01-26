import 'package:shared_preferences/shared_preferences.dart';

// Function to save a boolean preference
Future<void> savePreference(String key, bool value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool(key, value); // Save the boolean value
}

// Function to save a string preference
Future<void> saveStringPreference(String key, String value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString(key, value); // Save the string value
}

// Function to save an integer preference
Future<void> saveIntPreference(String key, int value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setInt(key, value); // Save the integer value
}

// Function to load a boolean preference
Future<bool> loadBooleanPreference(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool(key) ?? false; // Default to false if no value exists
}

// Function to load a string preference
Future<String?> loadStringPreference(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString(key); // Returns null if no value exists
}

// Function to load an integer preference
Future<int?> loadIntPreference(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getInt(key); // Returns null if no value exists
}

// // Save a boolean preference
// savePreference('isLoggedIn', true);

// // Save a string preference
// saveStringPreference('userName', 'JohnDoe');

// // Save an integer preference
// saveIntPreference('userAge', 25);

// // Load the boolean preference
// bool isLoggedIn = await loadBooleanPreference('isLoggedIn');

// // Load the string preference
// String? userName = await loadStringPreference('userName');

// // Load the integer preference
// int? userAge = await loadIntPreference('userAge');
