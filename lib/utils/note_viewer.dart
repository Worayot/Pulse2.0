import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class NoteViewer extends StatelessWidget {
  const NoteViewer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(top: size.height / 4),
      child: Stack(
        children: [
          SizedBox(
            height: size.height * 0.4,
            child: Card(
              margin: const EdgeInsets.all(16.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4.0,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title and Close Button Row
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "note".tr(),
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 60),

                    // Text Editor Field
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: TextField(
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                        ),
                        readOnly: true,
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 15,
            right: 15,
            child: IconButton(
              icon: Icon(Icons.close, size: size.height / 25),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          )
        ],
      ),
    );
  }
}
