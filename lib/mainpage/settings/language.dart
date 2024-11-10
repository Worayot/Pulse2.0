import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageSelectPage extends StatefulWidget {
  @override
  _LanguageSelectPageState createState() => _LanguageSelectPageState();
}

class _LanguageSelectPageState extends State<LanguageSelectPage> {
  Locale? _selectedLocale;

  @override
  void initState() {
    super.initState();
    _loadSelectedLocale(); // Load saved locale when page loads
  }

  // Load saved locale from shared preferences
  Future<void> _loadSelectedLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final String? languageCode = prefs.getString('languageCode');
    final String? countryCode = prefs.getString('countryCode');

    if (languageCode != null && countryCode != null) {
      setState(() {
        _selectedLocale = Locale(languageCode, countryCode);
        context.setLocale(_selectedLocale!); // Apply the saved locale
      });
    } else {
      _selectedLocale =
          context.locale; // Set to current locale if no saved data
    }
  }

  // Save the selected locale to shared preferences
  Future<void> _saveSelectedLocale(Locale locale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('languageCode', locale.languageCode);
    await prefs.setString('countryCode', locale.countryCode ?? '');
  }

  @override
  Widget build(BuildContext context) {
    // Set initial locale if not already set
    _selectedLocale ??= context.locale;

    return Scaffold(
      appBar: AppBar(
        title: Text('Language Setting'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "selectLanguage".tr(),
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20), // Add some space
            // Language options as ListTiles
            GestureDetector(
              onTap: () {
                _onLanguageSelected(
                    Locale('en', 'US')); // Set locale to English
              },
              child: ListTile(
                leading: Icon(Icons.language),
                title: Text('English'),
                trailing: _selectedLocale == Locale('en', 'US')
                    ? Icon(Icons.check,
                        color: Colors.green) // Checkmark for selected language
                    : null,
              ),
            ),
            Divider(), // Divider between menu items
            GestureDetector(
              onTap: () {
                _onLanguageSelected(Locale('th', 'TH')); // Set locale to Thai
              },
              child: ListTile(
                leading: Icon(Icons.language),
                title: Text('ไทย'),
                trailing: _selectedLocale == Locale('th', 'TH')
                    ? Icon(Icons.check,
                        color: Colors.green) // Checkmark for selected language
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onLanguageSelected(Locale locale) {
    setState(() {
      _selectedLocale = locale; // Update the selected locale
      context.setLocale(locale); // Apply the new locale
      _saveSelectedLocale(locale); // Save the locale to preferences
    });
  }
}
