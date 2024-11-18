import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  int _selectedLanguageIndex = 1;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadSelectedLocale();
    });
  }

  Future<void> _loadSelectedLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final String? languageCode = prefs.getString('languageCode');
    if (languageCode == 'en') {
      setState(() {
        _selectedLanguageIndex = 0;
        context.setLocale(const Locale('en', 'US'));
      });
    } else {
      setState(() {
        _selectedLanguageIndex = 1;
        context.setLocale(const Locale('th', 'TH')); // Default to Thai
      });
    }
  }

  Future<void> _saveSelectedLocale(Locale locale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('languageCode', locale.languageCode);
    await prefs.setString('countryCode', locale.countryCode ?? '');
  }

  void _toggleLanguage(int index) {
    Locale newLocale;
    if (index == 0) {
      newLocale = const Locale('en', 'US');
    } else {
      newLocale = const Locale('th', 'TH');
    }

    setState(() {
      _selectedLanguageIndex = index;
      context.setLocale(newLocale);
      _saveSelectedLocale(newLocale);
    });
  }

  void _login() {
    if (_formKey.currentState?.validate() ?? false) {
      print("Email: ${_emailController.text}");
      print("Password: ${_passwordController.text}");
    }
  }

  void _forgotPassword() {
    print("Forgot Password tapped");
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          // Center content (login form, etc.)
          Center(
            child: Padding(
              padding: EdgeInsets.all(size.width / 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'MEWS',
                    style: TextStyle(
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    color: const Color(0xffE8F6F3),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: size.width / 10,
                          horizontal: size.width / 15),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ToggleButtons(
                                isSelected: [
                                  _selectedLanguageIndex == 0,
                                  _selectedLanguageIndex == 1
                                ],
                                onPressed: _toggleLanguage,
                                borderRadius: BorderRadius.circular(10),
                                selectedColor: Colors.white,
                                fillColor: const Color(0xff1225A4),
                                color: Colors.black,
                                constraints: const BoxConstraints(
                                    minWidth: 70, minHeight: 36),
                                children: const [
                                  Text('English'),
                                  Text('ไทย'),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              labelText: "email".tr(),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              prefixIcon: const Icon(Icons.email,
                                  color: Color(0xff2D6A4F)),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                  .hasMatch(value)) {
                                return 'Please enter a valid email';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: size.height / 50),
                          TextFormField(
                            controller: _passwordController,
                            decoration: InputDecoration(
                              labelText: "password".tr(),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              prefixIcon: const Icon(Icons.lock,
                                  color: Color(0xff2D6A4F)),
                            ),
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              } else if (value.length < 6) {
                                return 'Password must be at least 6 characters';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 10),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InkWell(
                                    onTap: _forgotPassword,
                                    child: Text(
                                      "forgotPassword".tr(),
                                      style: const TextStyle(
                                        color: Colors.black,
                                        decoration: TextDecoration.underline,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  const Text(
                                    "?", // This part will not have an underline and won't be clickable
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 40),
                          SizedBox(
                            width: 240,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color(0xff1225A4).withOpacity(0.65),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                              ),
                              onPressed: _login,
                              child: Text(
                                "login".tr(),
                                style: const TextStyle(
                                    fontSize: 22, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            top: size.height / 6,
            left: -30, // This sticks the image to the left side of the screen
            child: Container(
              width: 150, // Adjust width as necessary
              height: 150, // Adjust height as necessary
              child: Image.asset(
                'assets/images/img_login_top.png',
                fit: BoxFit.contain, // Adjust the image's fit to your needs
              ),
            ),
          ),
          // Bottom image positioned above the green card
          Positioned(
            bottom: -80, // Adjust bottom position so it overlaps with the card
            left: 0,
            right: 0,
            child: Container(
              width: size.width / 4, // Full width of the screen
              height: size.height / 3.2, // Adjust height as needed
              child: Image.asset(
                'assets/images/img_login_bottom.png',
                fit: BoxFit.contain, // Stretch the image to cover the container
              ),
            ),
          ),
        ],
      ),
    );
  }
}
