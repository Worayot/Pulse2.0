import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pulse/utils/action_button.dart';
import 'package:pulse/utils/add_user_form.dart';
import 'package:pulse/utils/custom_header.dart';
import 'package:pulse/utils/delete_user_dialog.dart';
import 'package:pulse/utils/edit_user_form.dart';
import 'package:pulse/utils/symbols_dialog/info_dialog.dart';
import 'package:pulse/utils/symbols_dialog/user_manager_symbols.dart';

class User {
  final String name;
  final String surname;
  final String nurseID;
  final String position;

  User(
      {required this.name,
      required this.surname,
      required this.nurseID,
      required this.position});
}

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final List<User> _users = [
    User(name: "John", surname: "Doe", nurseID: "123123", position: "Admin"),
    User(
        name: "Worayot",
        surname: "Liamkaew",
        nurseID: "123123",
        position: "Nurse"),
    User(
        name: "Minecraft",
        surname: "Java",
        nurseID: "123123",
        position: "Nurse"),
  ];

  List<User> _filteredUsers = [];
  String _searchText = '';

  @override
  void initState() {
    super.initState();
    _filteredUsers = _users; // Initially show all users
  }

  void _filterUsers(String query) {
    setState(() {
      _searchText = query.toLowerCase();
      _filteredUsers = _users.where((user) {
        return user.name.toLowerCase().contains(_searchText) ||
            user.surname.toLowerCase().contains(_searchText);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(automaticallyImplyLeading: false, title: header()),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Row(
                  children: [
                    const Icon(FontAwesomeIcons.backward), // Back icon
                    const SizedBox(width: 8),
                    Text(
                      'back'.tr(),
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Text(
                    "userManagement".tr(),
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      onChanged: _filterUsers,
                      decoration: InputDecoration(
                        hintText: "${"search".tr()}...",
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          borderSide: BorderSide.none,
                        ),
                        prefixIcon: const Icon(
                          FontAwesomeIcons.magnifyingGlass,
                          color: Colors.black,
                        ),
                        filled: true,
                        fillColor: const Color(0xffCADBFF),
                        labelStyle: const TextStyle(color: Colors.black),
                      ),
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: 120,
                    height: 55,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const AddUserForm();
                            });
                      },
                      icon: const Icon(
                        FontAwesomeIcons.personCirclePlus,
                        size: 30,
                        color: Colors.white,
                      ),
                      label: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "addUser".tr(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                          softWrap: true,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff407bff),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 16)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: _filteredUsers.length,
                  itemBuilder: (context, index) {
                    final user = _filteredUsers[index];
                    return Stack(
                      children: [
                        Card(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          color: const Color(0xffE0EAFF),
                          child: ListTile(
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${user.name} ${user.surname}",
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                          Text.rich(
                                            TextSpan(
                                              children: <TextSpan>[
                                                TextSpan(
                                                  text: "${"position".tr()} ",
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontSize: 11),
                                                ),
                                                TextSpan(
                                                  text: "${user.position} ",
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 11),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Text.rich(
                                            TextSpan(
                                              children: <TextSpan>[
                                                TextSpan(
                                                  text: "${"nurseID".tr()} ",
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontSize: 11),
                                                ),
                                                TextSpan(
                                                  text: "${user.nurseID} ",
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 11),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          right: -1,
                          top: 0,
                          bottom: 8,
                          child: IgnorePointer(
                            child: SizedBox(
                              height: 180, // Adjust the height
                              width: 180, // Adjust the width
                              child: Image.asset(
                                "assets/images/therapy3.png",
                                fit: BoxFit
                                    .contain, // Ensures the image fits within the box
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          bottom: 0,
                          right: 13,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                height: 30,
                                width: 55,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      foregroundColor: const Color(0xff3362CC),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      padding: EdgeInsets.zero,
                                      // fixedSize: const Size(10, 30),
                                      elevation: 0),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return const EditUserForm();
                                      },
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 0, horizontal: 0),
                                    child: Text(
                                      'edit'.tr(), // Replace with your text
                                      style: const TextStyle(
                                          color: Color(0xff3362CC),
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              buildActionButton(FontAwesomeIcons.userMinus, () {
                                showDeleteUserDialog(context);
                              }, Colors.white, const Color(0xffE45B5B)),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ));
  }
}