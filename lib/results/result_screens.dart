import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pulse/utils/note_adder.dart';

void showResultDialog(BuildContext context, int MEWs) {
  List<dynamic> components = getComponent(MEWs);
  String nursing = components[0];
  String emoji = components[1];
  Color bgColor = components[2];
  String title = components[3];

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                width: double.infinity,
                color: bgColor,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Center(
                              child: Text(
                                "finishedCalculating".tr(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "\t\t${"totalScore".tr()}: $MEWs",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Wrap the scrollable container with Expanded to handle overflow
                    Expanded(
                      child: SingleChildScrollView(
                        child: Container(
                          padding: const EdgeInsets.all(16.0),
                          width: 300,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  title,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "${"nursing".tr()}:",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    height: 0.5,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              // The nursing text is now scrollable
                              SingleChildScrollView(
                                child: Text(
                                  nursing,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: ElevatedButton.icon(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return NoteAdder(
                                    onSave: () {},
                                  );
                                },
                              );
                            },
                            icon: const Icon(FontAwesomeIcons.solidPenToSquare,
                                color: Colors.white),
                            label: Text(
                              'addNote'.tr(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF565656),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Make the emoji non-interactive by wrapping with IgnorePointer
            Positioned(
              bottom: 0,
              right: 0,
              child: IgnorePointer(
                child: Opacity(
                  opacity: 0.5, // Set opacity here (0.0 to 1.0)
                  child: Image.asset(emoji),
                ),
              ),
            ),

            // Close button remains fixed
            Positioned(
              top: 20,
              right: 20,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(FontAwesomeIcons.xmark, color: Colors.black),
              ),
            ),
          ],
        ),
      );
    },
  );
}

List<dynamic> getComponent(int MEWs) {
  // Process MEWs
  String nursing = "";
  String emoji;
  Color bgColor;
  String title = "";
  if (MEWs <= 1) {
    nursing = "nursingLow".tr();
    emoji = "assets/images/emojis/emoji_low.png";
    bgColor = const Color(0xffCEFF9F);
    title = "lowRisk".tr();
  } else if (MEWs == 2) {
    nursing = "nursingLowMedium".tr();
    emoji = "assets/images/emojis/emoji_midlow.png";
    bgColor = const Color(0xffFFF9AD);
    title = "lowRisk".tr();
  } else if (MEWs == 3) {
    nursing = "nursingMedium".tr();
    emoji = "assets/images/emojis/emoji_mid.png";
    title = "medRisk".tr();
    bgColor = const Color(0xffFFE897);
  } else if (MEWs == 4) {
    nursing = "nursingMediumHigh".tr();
    emoji = "assets/images/emojis/emoji_midhigh.png";
    bgColor = const Color(0xffFFD2B8);
    title = "medhighRisk".tr();
  } else if (MEWs >= 5) {
    nursing = "nursingHigh".tr();
    emoji = "assets/images/emojis/emoji_high.png";
    bgColor = const Color(0xffFFBE99);
    title = "highRisk".tr();
  } else {
    nursing = "Error";
    emoji = "assets/images/emojis/emoji_high.png";
    bgColor = const Color.fromARGB(255, 255, 51, 211);
  }

  return [nursing, emoji, bgColor, title];
}
