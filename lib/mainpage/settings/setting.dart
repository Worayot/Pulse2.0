import 'dart:convert';
import 'dart:math';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pulse/mainpage/settings/aboutapp.dart';
import 'package:pulse/mainpage/settings/admin.dart';
import 'package:pulse/mainpage/settings/language.dart';
import 'package:pulse/mainpage/settings/profile.dart';
import 'package:pulse/utils/custom_header.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late Future<List<Map<String, String>>> quotes; // Quotes Future

  @override
  void initState() {
    super.initState();
    quotes = loadQuotes();
  }

  Future<List<Map<String, String>>> loadQuotes() async {
    try {
      final String response =
          await rootBundle.loadString('assets/quotes/quotes.json');
      final List<dynamic> data = json.decode(response);

      // Ensure every dynamic map is safely cast to Map<String, String>
      return data.map((item) {
        if (item is Map<String, dynamic>) {
          return {
            'quote': item['quote'].toString(),
            'author': item['author'].toString(),
          };
        } else {
          throw const FormatException("Invalid JSON format");
        }
      }).toList();
    } catch (e) {
      print('Error loading quotes.json: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: header()),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                // User Info Section
                const SizedBox(height: 40),
                // Menu ListTiles
                _buildSettingsTile(
                  title: 'profileSetting'.tr(),
                  leadingIcon: FontAwesomeIcons.solidAddressBook,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProfileSettingsPage()),
                  ),
                ),
                _buildSettingsTile(
                  title: 'aboutApp'.tr(),
                  leadingIcon: FontAwesomeIcons.circleInfo,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AboutAppPage()),
                  ),
                ),
                _buildSettingsTile(
                  title: 'language'.tr(),
                  leadingIcon: FontAwesomeIcons.globe,
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LanguageSelectPage()),
                    );
                    setState(() {});
                  },
                ),
                _buildSettingsTile(
                  title: 'admin'.tr(),
                  leadingIcon: FontAwesomeIcons.userTie,
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AdminPage()),
                    );
                  },
                ),

                const SizedBox(height: 30),
                Align(
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: _logout,
                    child: Text(
                      "logout".tr(),
                      style: const TextStyle(
                          color: Colors.red,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(height: 40),

                // Random Quote Section using FutureBuilder
                FutureBuilder<List<Map<String, String>>>(
                  future: quotes,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text(
                        'Error loading quotes: ${snapshot.error}',
                        style: const TextStyle(color: Colors.red),
                      );
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Text('No quotes found.');
                    }

                    final loadedQuotes = snapshot.data!;
                    final random = Random();
                    final selectedQuote =
                        loadedQuotes[random.nextInt(loadedQuotes.length)];

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 180,
                                child: Text.rich(TextSpan(children: [
                                  const TextSpan(
                                      text: '"',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        height: 1.8,
                                      )),
                                  TextSpan(
                                    text: selectedQuote['quote']![0],
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      height: 1.8,
                                    ),
                                  ),
                                  TextSpan(
                                      text:
                                          '${selectedQuote['quote']!.substring(1)}"',
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        height: 1.8,
                                      ))
                                ])),
                              ),
                              const SizedBox(height: 10),
                              SizedBox(
                                width: 180,
                                child: Text(
                                  selectedQuote['author']!,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 40,
            right: -110,
            child: Image.asset(
              'assets/images/hospital.png', // Ensure this path is correct
              width: 400, // Increased width
              height: 300, // Increased height
              fit: BoxFit.contain,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSettingsTile({
    required String title,
    required IconData leadingIcon,
    required VoidCallback onTap,
  }) {
    return ListTile(
      title: Text(title),
      leading: FaIcon(
        leadingIcon,
        color: const Color(0xff3362CC),
      ),
      trailing: const FaIcon(FontAwesomeIcons.arrowRight),
      onTap: onTap,
    );
  }

  void _logout() {
    print('Logout tapped');
  }
}
