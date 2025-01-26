import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  // Combined Future to load both name and nurseID
  Future<Map<String, String>> _getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String name = prefs.getString('name') ?? 'Default Name'; // Default if null
    String nurseID = prefs.getString('nurseID') ?? ''; // Default if null
    return {'name': name, 'nurseID': nurseID};
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: FutureBuilder<Map<String, String>>(
        future: _getUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator(); // Show a loading spinner
          } else if (snapshot.hasError) {
            return const Text('Error loading user data'); // Handle errors
          } else {
            String name = snapshot.data?['name'] ?? 'N/A'; // Fallback if null
            String nurseID =
                snapshot.data?['nurseID'] ?? ''; // Fallback if null
            String firstLetter =
                name.isNotEmpty ? name[0] : 'N'; // Get the first letter
            return Row(
              children: [
                CircleAvatar(
                  radius: 28,
                  child: Text(
                    firstLetter,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name, // Full name from SharedPreferences
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${"nurseID".tr()} : $nurseID', // User ID from SharedPreferences
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
