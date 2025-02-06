import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String name = "วรยศ เลี่ยมแก้ว";
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(60),
                    child: Container(
                      width: size.width / 1.2,
                      height: 80,
                      decoration: const BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Color(0xffCCE9FF),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: const LinearProgressIndicator(
                            minHeight: 10,
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Color(0xff1125A4)),
                            backgroundColor: Color(0xffB0D3EF),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    '${'welcome'.tr()}!',
                    style: const TextStyle(
                        fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    name,
                    style: const TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
