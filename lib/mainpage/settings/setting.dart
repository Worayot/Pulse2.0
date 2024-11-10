import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pulse/mainpage/settings/aboutapp.dart';
import 'package:pulse/mainpage/settings/language.dart';
import 'package:pulse/mainpage/settings/profile.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('settings'.tr()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              title: Text('profileSetting'.tr()),
              leading: const Icon(Icons.account_circle),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProfileSettingsPage()),
                );
              },
            ),
            Divider(), // Divider between items
            ListTile(
              title: Text('aboutApp'.tr()),
              leading: Icon(Icons.privacy_tip),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AboutAppPage()),
                );
              },
            ),
            Divider(), // Divider between items
            ListTile(
              title: Text('language'.tr()),
              leading: Icon(Icons.language),
              onTap: () async {
                // Push the language selection page and wait for the result
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LanguageSelectPage()),
                );

                // After returning, trigger the language refresh
                setState(() {});
              },
            ),
            const Divider(),
            const SizedBox(height: 40),
            Align(
              alignment: Alignment.center,
              child: InkWell(
                onTap: _logout,
                child: Text(
                  "logout".tr(),
                  style: const TextStyle(color: Colors.red, fontSize: 18),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _logout() {
    // Implement logout functionality here
  }
}
