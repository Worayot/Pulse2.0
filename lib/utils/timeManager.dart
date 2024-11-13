import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void showTimeManager(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 0),
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15), // Adjust radius here
            ),
            title: Row(
              children: [
                Text(
                  "notifications".tr(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(
                    FontAwesomeIcons.xmark, // The icon to display
                    color: Colors.black, // Icon color
                    size: 30, // Icon size
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
            contentPadding: const EdgeInsets.only(left: 0, right: 0, bottom: 0),
            content: Stack(
              children: [
                Center(
                  child: Container(
                    width: 240,
                    height: 240,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Color(0xffC6D8FF),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: -20,
                  child: Opacity(
                    opacity: 1,
                    child: Image.asset(
                      './assets/images/timeline.png',
                      width: 270,
                      height: 270,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                // Main content
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "${"setTimer".tr()}:",
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 150,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(width: 30),
                          // "O'clock" timer picker
                          Expanded(
                            child: ListWheelScrollView.useDelegate(
                              itemExtent: 50,
                              perspective: 0.005,
                              physics: const FixedExtentScrollPhysics(),
                              childDelegate: ListWheelChildLoopingListDelegate(
                                children: List<Widget>.generate(24, (index) {
                                  return Center(
                                    child: Text(
                                      index.toString().padLeft(2, '0'),
                                      style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ),
                          ),
                          const Text(
                            ":",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          // "Minute" timer picker
                          Expanded(
                            child: ListWheelScrollView.useDelegate(
                              itemExtent: 50,
                              perspective: 0.005,
                              physics: const FixedExtentScrollPhysics(),
                              childDelegate: ListWheelChildLoopingListDelegate(
                                children: List<Widget>.generate(60, (index) {
                                  return Center(
                                    child: Text(
                                      index.toString().padLeft(2, '0'),
                                      style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ),
                          ),
                          const SizedBox(width: 30),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 24,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text("setNotification".tr()),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ],
            ),
          ),
        );
      });
}
