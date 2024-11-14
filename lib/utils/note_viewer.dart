import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NoteViewer extends StatefulWidget {
  const NoteViewer({Key? key}) : super(key: key);

  @override
  State<NoteViewer> createState() => _NoteViewerState();
}

class _NoteViewerState extends State<NoteViewer> {
  bool isSecondButtonSelected = false;
  final FocusNode _focusNodeNoteContainer = FocusNode();
  final FocusNode _focusNodeMovingWidget = FocusNode();
  bool isNoteFocused = false;

  // Track the index of the focused note
  int focusedIndex = -1;

  List<Patient> patients = [
    Patient(editBy: 'Dr. Smith', note: 'Patient is recovering well.'),
    Patient(editBy: 'Dr. Lee', note: 'Patient shows signs of improvement.'),
    Patient(editBy: 'Dr. Johnson', note: 'Patient needs further tests.'),
    Patient(editBy: 'Dr. Smith', note: 'Patient is recovering well.'),
    Patient(editBy: 'Dr. Lee', note: 'Patient shows signs of improvement.'),
    Patient(editBy: 'Dr. Johnson', note: 'Patient needs further tests.'),
  ];

  // List of controllers for each note
  List<TextEditingController> controllers = [];

  @override
  void initState() {
    super.initState();

    // Initialize a TextEditingController for each note
    for (var patient in patients) {
      controllers.add(TextEditingController(text: patient.note));
    }

    _focusNodeNoteContainer.addListener(() {
      setState(() {
        isNoteFocused = _focusNodeNoteContainer.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNodeNoteContainer.dispose();
    _focusNodeMovingWidget.dispose();

    for (var controller in controllers) {
      controller.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xFFF5F5F5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Text(
                    "note".tr(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                ),
                SizedBox(height: isSecondButtonSelected ? 100 : 10),
                if (!isSecondButtonSelected) noteContainer(context),
                movingWidget(context),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // First Button
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            isSecondButtonSelected = false;
                          });
                          FocusScope.of(context).unfocus();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isSecondButtonSelected
                              ? const Color(0xFF3362CC) // Selected color
                              : const Color(0xFF407BFF), // Unselected color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 4),
                        ),
                        child: Text(
                          'view/edit'.tr(),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    // Second Button
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            isSecondButtonSelected = true;
                          });
                          FocusScope.of(context)
                              .requestFocus(_focusNodeMovingWidget);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: !isSecondButtonSelected
                              ? const Color(0xFF3362CC) // Selected color
                              : const Color(0xFF407BFF), // Unselected color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 1),
                        ),
                        child: Text(
                          'addNote'.tr(),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: IconButton(
              icon: const Icon(
                FontAwesomeIcons.xmark, // Close icon
                color: Colors.black,
                size: 30,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
    );
  }

  // Separate method for noteContainer
  Widget noteContainer(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: isSecondButtonSelected ? 100 : 400,
      child: SingleChildScrollView(
        child: Column(
          children: patients.asMap().entries.map((entry) {
            int index = entry.key;
            Patient patient = entry.value;
            return noteEditor(context, _focusNodeNoteContainer, patient, index);
          }).toList(),
        ),
      ),
    );
  }

  // Update noteEditor to show editable text field when tapped
  Widget noteEditor(BuildContext context, _focusNodeNoteContainer,
      Patient patient, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          // Set the focused index when a note is tapped
          focusedIndex = index;
        });
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(right: 10.0),
                decoration: BoxDecoration(
                  color: focusedIndex == index
                      ? const Color(
                          0xffFFF9AD) // Yellow background when focused
                      : const Color(0xffE0EAFF), // Default color
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(5),
                    bottomRight: Radius.circular(5),
                  ),
                ),
                child: IntrinsicHeight(
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: focusedIndex == index
                              ? const Color(0xffFAD505)
                              : const Color(0xff407BFF),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(5),
                            bottomLeft: Radius.circular(5),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 0),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                '${index + 1}', // Display index + 1
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: focusedIndex == index
                              ? TextField(
                                  controller: controllers[index],
                                  focusNode: _focusNodeNoteContainer,
                                  maxLines: null,
                                  style: const TextStyle(
                                      fontSize:
                                          14), // Set your desired font size here
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Enter your note...',
                                  ),
                                )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      patient.note, // Display note text
                                      softWrap: true,
                                      overflow: TextOverflow.visible,
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Text(
                                        "โดย ${patient.editBy}",
                                        softWrap: true,
                                        overflow: TextOverflow.visible,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Color(0xff565656),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      ),
                      focusedIndex == index
                          ? Material(
                              elevation: 1,
                              shape:
                                  const CircleBorder(), // Make sure the material has a circular shape
                              color: Colors
                                  .transparent, // Set transparent color for material (only shadow is visible)
                              child: CircleAvatar(
                                radius: 15,
                                backgroundColor: const Color(0xffFAD505),
                                child: IconButton(
                                  icon: const Icon(
                                    FontAwesomeIcons
                                        .solidFloppyDisk, // Icon for the save action
                                    color: Colors.white, // Icon color
                                    size: 15, // Icon size
                                  ),
                                  onPressed: () {},
                                ),
                              ),
                            )
                          : const Icon(FontAwesomeIcons.penClip,
                              color: Color(0xff3362CC)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget movingWidget(BuildContext context) {
    return Column(
      children: [
        IgnorePointer(
          ignoring: !isSecondButtonSelected,
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  focusNode: _focusNodeMovingWidget,
                  decoration: InputDecoration(
                    border: const UnderlineInputBorder(),
                    labelText: isSecondButtonSelected ? 'enterNote'.tr() : "",
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  autofocus: isSecondButtonSelected,
                ),
              ),
              if (isSecondButtonSelected)
                IconButton(
                  icon: const Icon(FontAwesomeIcons.circlePlus,
                      color: Color(0xff407BFF)),
                  onPressed: () {},
                ),
            ],
          ),
        ),
        // AnimatedContainer(
        //     duration: const Duration(milliseconds: 200),
        //     height: isSecondButtonSelected ? 175 : 0)
      ],
    );
  }
}

class Patient {
  String editBy;
  String note;

  Patient({
    required this.editBy,
    required this.note,
  });
}
