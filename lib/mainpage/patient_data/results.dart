import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class MewsResultWidget extends StatelessWidget {
  final String mews;

  // Constructor
  const MewsResultWidget({Key? key, required this.mews}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Process MEWs
    String nursing = "";
    int? _MEWs = int.tryParse(mews);

    if (_MEWs == null) {
      return const SizedBox(); // Return an empty widget if MEWs is not a valid integer
    }

    if (_MEWs <= 1) {
      nursing = "nursingLow".tr();
    } else if (_MEWs == 2) {
      nursing = "nursingLowMedium".tr();
    } else if (_MEWs == 3) {
      nursing = "nursingMedium".tr();
    } else if (_MEWs == 4) {
      nursing = "nursingMediumHigh".tr();
    } else if (_MEWs >= 5) {
      nursing = "nursingHigh".tr();
    }

    return SizedBox(
      width: 260,
      child: Column(
        children: [
          const SizedBox(height: 25),
          Row(
            children: [
              Text(
                "${"latestMEWs".tr()} : ",
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(
                  mews,
                  style: const TextStyle(
                      fontSize: 40, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              nursing,
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.left,
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }
}
