import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileSettingsPage extends StatefulWidget {
  @override
  _ProfileSettingsPageState createState() => _ProfileSettingsPageState();
}

class _ProfileSettingsPageState extends State<ProfileSettingsPage> {
  String _name = "";
  String _contactInfo = "";
  String _email = "";
  String _nurseId = "";

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  // Load saved data from shared preferences
  Future<void> _loadProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _name = prefs.getString('name') ?? "N/A";
      _contactInfo = prefs.getString('contactInfo') ?? "N/A";
      _email = prefs.getString('email') ?? "N/A";
      _nurseId = prefs.getString('nurseId') ?? "N/A";
    });
  }

  // Save data to shared preferences
  Future<void> _saveProfileData(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  // Show an editable dialog box and save the data on edit
  Future<void> _showEditDialog(String title, String currentValue,
      Function(String) onSave, String prefsKey) async {
    final TextEditingController controller =
        TextEditingController(text: currentValue);

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit $title'),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: 'Enter $title',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), // Cancel button
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final newValue = controller.text;
              onSave(newValue); // Update the state
              _saveProfileData(
                  prefsKey, newValue); // Save to shared preferences
              Navigator.pop(context);
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Name (Editable)
            InkWell(
              onTap: () => _showEditDialog('Name-Surname', _name, (newValue) {
                setState(() {
                  _name = newValue;
                });
              }, 'name'),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Name-Surname',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            _name,
                            style: TextStyle(
                                fontSize: 16, color: Colors.grey[700]),
                          ),
                        ],
                      ),
                    ),
                    Icon(Icons.edit, color: Colors.grey),
                  ],
                ),
              ),
            ),
            Divider(),

            // Surname (Editable)
            InkWell(
              onTap: () =>
                  _showEditDialog('Contact Info', _contactInfo, (newValue) {
                setState(() {
                  _contactInfo = newValue;
                });
              }, 'contactInfo'),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Contact Information',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            _contactInfo,
                            style: TextStyle(
                                fontSize: 16, color: Colors.grey[700]),
                          ),
                        ],
                      ),
                    ),
                    Icon(Icons.edit, color: Colors.grey),
                  ],
                ),
              ),
            ),
            Divider(),

            // Contact Info (Non-editable)
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Email',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        _email,
                        style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Divider(),

            // Nurse ID (Non-editable)
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Nurse ID',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        _nurseId,
                        style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
