import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pulse/utils/custom_header.dart';
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

  // Track if a field is being edited
  bool _isEditingName = false;
  bool _isEditingContact = false;

  // Controllers to track TextField changes
  TextEditingController _nameController = TextEditingController();
  TextEditingController _contactController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _name = prefs.getString('name') ?? "N/A";
      _contactInfo = prefs.getString('contactInfo') ?? "N/A";
      _email = prefs.getString('email') ?? "N/A";
      _nurseId = prefs.getString('nurseId') ?? "N/A";

      // Initialize the controllers with saved data
      _nameController.text = _name;
      _contactController.text = _contactInfo;
    });
  }

  Future<void> _saveProfileData(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  void _toggleEditMode(String field) {
    setState(() {
      if (field == 'name') {
        _isEditingName = !_isEditingName;
        if (!_isEditingName) {
          // Save changes when exiting edit mode
          _saveChanges('name', _nameController.text);
        }
      } else if (field == 'contact') {
        _isEditingContact = !_isEditingContact;
        if (!_isEditingContact) {
          // Save changes when exiting edit mode
          _saveChanges('contact', _contactController.text);
        }
      }
    });
  }

  void _saveChanges(String field, String newValue) {
    if (field == 'name') {
      _name = newValue;
      _saveProfileData('name', newValue);
    } else if (field == 'contact') {
      _contactInfo = newValue;
      _saveProfileData('contact', newValue);
    }
    setState(() {}); // Refresh the state to display the updated name/contact
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: header(),
        toolbarHeight: 80,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Container(
              height: 600,
              decoration: BoxDecoration(
                color: const Color(0xFFB2C2E5),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Stack(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0, left: 16),
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Row(
                            children: [
                              const Icon(
                                FontAwesomeIcons.backward,
                                color: Colors.black,
                                size: 25,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                'back'.tr(),
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Center(
                        child: Text(
                          "userAccount".tr(),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50), // White box outer padding
                        child: Container(
                          padding: const EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.75),
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                // Name-Surname
                                InkWell(
                                  onTap: () => _toggleEditMode('name'),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'name-surname'.tr(),
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black),
                                              ),
                                              const SizedBox(height: 4),
                                              _isEditingName
                                                  ? TextField(
                                                      onSubmitted: (newValue) =>
                                                          _saveChanges(
                                                              'name', newValue),
                                                      controller:
                                                          _nameController,
                                                      decoration:
                                                          const InputDecoration(
                                                        border:
                                                            UnderlineInputBorder(),
                                                      ),
                                                    )
                                                  : Text(
                                                      _name,
                                                      style: const TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.black),
                                                    ),
                                            ],
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: _isEditingName
                                              ? IconButton(
                                                  onPressed: () => _saveChanges(
                                                      'name',
                                                      _nameController
                                                          .text), // Save the new name
                                                  icon: const Icon(
                                                      FontAwesomeIcons
                                                          .chevronRight),
                                                  color: Colors.black,
                                                )
                                              : const Icon(
                                                  Icons.edit,
                                                  color: Colors.black,
                                                ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 12), // Adjusted spacing

                                // Contact Information
                                InkWell(
                                  onTap: () => _toggleEditMode('contact'),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'contact'.tr(),
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black),
                                              ),
                                              const SizedBox(height: 4),
                                              _isEditingContact
                                                  ? TextField(
                                                      onSubmitted: (newValue) =>
                                                          _saveChanges(
                                                              'contact',
                                                              newValue),
                                                      controller:
                                                          _contactController,
                                                      decoration:
                                                          const InputDecoration(
                                                        border:
                                                            UnderlineInputBorder(),
                                                      ),
                                                    )
                                                  : Text(
                                                      _contactInfo,
                                                      style: const TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.black),
                                                    ),
                                            ],
                                          ),
                                        ),
                                        // Align icons
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: _isEditingContact
                                              ? IconButton(
                                                  onPressed: () => _saveChanges(
                                                      'contact',
                                                      _contactController
                                                          .text), // Save the new contact
                                                  icon: const Icon(
                                                      FontAwesomeIcons
                                                          .chevronRight),
                                                  color: Colors.black,
                                                )
                                              : const Icon(
                                                  Icons.edit,
                                                  color: Colors.black,
                                                ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 12), // Adjusted spacing

                                // Email
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'email'.tr(),
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            _email,
                                            style: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12), // Adjusted spacing

                                // Nurse ID
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'nurseID'.tr(),
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          ),
                                          const SizedBox(
                                              height: 4), // Balanced spacing
                                          Text(
                                            _nurseId,
                                            style: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 140)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                      bottom: -50,
                      right: -30,
                      child: IgnorePointer(
                          child: Image.asset("assets/images/ambulance.png")))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
