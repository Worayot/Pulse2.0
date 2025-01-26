import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void showTimeManager(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 200),
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15), // Adjust radius here
            ),
            contentPadding:
                const EdgeInsets.only(left: 0, right: 0, bottom: 0, top: 0),
            content: SizedBox(
              height: 400,
              child: Stack(
                children: [
                  Positioned(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Text(
                            "notifications".tr(),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          icon: const Icon(
                            Icons.close,
                            color: Colors.black,
                            size: 30,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
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
                  Stack(
                    children: [
                      Positioned(
                        top: 38,
                        bottom: 0,
                        right: 0,
                        left: 0,
                        child: FractionallySizedBox(
                            alignment: Alignment.center,
                            widthFactor: 0.6, // Percentage of width
                            heightFactor: 0.2, // Percentage of height
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape
                                    .rectangle, // Ensure it's a rectangle shape
                                color:
                                    const Color(0xffC6D8FF), // Background color
                                borderRadius: BorderRadius.circular(
                                    15), // Set the border radius for rounded corners
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(
                                        0.15), // Shadow color (use opacity for softness)
                                    offset: const Offset(0.5,
                                        0.25), // Shadow offset, here it's 4px on the Y-axis
                                    blurRadius:
                                        1, // Blur radius, controls the softness of the shadow
                                    spreadRadius:
                                        1, // Spread radius, controls how far the shadow spreads
                                  ),
                                ],
                              ),
                            )),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 60.0),
                            child: Text(
                              "setTimer".tr(),
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const SizedBox(height: 40),
                          Center(
                            child: SizedBox(
                              height: 130,
                              width: 160,
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
                                      childDelegate:
                                          ListWheelChildLoopingListDelegate(
                                        children:
                                            List<Widget>.generate(24, (index) {
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
                                      childDelegate:
                                          ListWheelChildLoopingListDelegate(
                                        children:
                                            List<Widget>.generate(60, (index) {
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
                          ),
                          const SizedBox(height: 30),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                  horizontal: 20,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                backgroundColor: const Color(0xffC6D8FF)),
                            child: Text("setNotification".tr(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)),
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      });
}
