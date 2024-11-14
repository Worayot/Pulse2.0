import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pulse/utils/note_viewer.dart';

class InspectionTimeRow extends StatelessWidget {
  final String time;
  const InspectionTimeRow({super.key, required this.time});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(children: [
              ElevatedButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const NoteViewer();
                      });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white, // Button background color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // Rounded corners
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 6), // Padding inside the button
                  elevation: 1, // Adds a subtle shadow for the elevated effect
                ),
                child: Text(
                  "$time น.",
                  style: const TextStyle(color: Colors.black), // Text color
                ),
              ),
              const Spacer(),
              Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                child: const Icon(FontAwesomeIcons.solidClipboard,
                    color: Color(0xff3362CC)),
              )
            ])),
      ],
    );
  }
}
