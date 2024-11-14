import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NoteViewer extends StatefulWidget {
  const NoteViewer({Key? key}) : super(key: key);

  @override
  State<NoteViewer> createState() => _NoteViewerState();
}

class _NoteViewerState extends State<NoteViewer>
    with SingleTickerProviderStateMixin {
  bool isSecondButtonSelected = false;
  final FocusNode _focusNodeNoteContainer = FocusNode();
  final FocusNode _focusNodeMovingWidget = FocusNode();
  bool isNoteFocused = false;

  // Animation controller for sliding effect
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  // Track the index of the focused note
  int focusedIndex = -1;

  // Patient list with notes
  List<Patient> patients = [
    Patient(editBy: 'Dr. Smith', note: 'Patient is recovering well.'),
    Patient(editBy: 'Dr. Lee', note: 'Patient shows signs of improvement.'),
    Patient(editBy: 'Dr. Johnson', note: 'Patient needs further tests.'),
    Patient(editBy: 'Dr. Smith', note: 'Patient is recovering well.'),
    Patient(editBy: 'Dr. Lee', note: 'Patient shows signs of improvement.'),
    Patient(editBy: 'Dr. Johnson', note: 'Patient needs further tests.'),
  ];

  // List of controllers for each note
  late List<TextEditingController> controllers;

  @override
  void initState() {
    super.initState();

    // Initialize controllers list with a TextEditingController for each patient note
    controllers =
        List.generate(patients.length, (index) => TextEditingController());

    // Initialize the AnimationController
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500), // Duration for sliding
    );

    // Initialize the slide animation
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1), // Start below the screen
      end: Offset.zero, // End at normal position
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut, // Smooth sliding
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    _focusNodeNoteContainer.dispose();
    _focusNodeMovingWidget.dispose();

    // Dispose controllers to avoid memory leaks
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Title at the top
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Text(
                "note".tr(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
            ),
          ),

          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: isSecondButtonSelected ? 100 : 400,
            child: isSecondButtonSelected
                ? Container() // Hide patient notes when adding a new note
                : SingleChildScrollView(
                    child: Column(
                      children: patients.asMap().entries.map((entry) {
                        int index = entry.key;
                        Patient patient = entry.value;
                        return noteEditor(
                            context, _focusNodeNoteContainer, patient, index);
                      }).toList(),
                    ),
                  ),
          ),
          SlideTransition(
            position: _slideAnimation,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Top spacing that animates
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    height: isSecondButtonSelected ? 70 : 0,
                  ),

                  Row(
                    children: [
                      // Expanded TextField to take up available space
                      if (isSecondButtonSelected)
                        Expanded(
                          child: Column(
                            children: [
                              TextField(
                                controller: focusedIndex >= 0
                                    ? controllers[focusedIndex]
                                    : null,
                                focusNode: _focusNodeMovingWidget,
                                maxLines: null,
                                enabled: isSecondButtonSelected,
                                decoration: InputDecoration(
                                  hintText: 'enterYourNote'.tr(),
                                ),
                              ),
                            ],
                          ),
                        ),

                      // CirclePlus Icon
                      if (isSecondButtonSelected)
                        Padding(
                          padding: const EdgeInsets.only(left: 2.0),
                          child: Material(
                            elevation: 2,
                            shape: const CircleBorder(),
                            color: Colors.transparent,
                            child: CircleAvatar(
                              radius: 18,
                              backgroundColor:
                                  const Color(0xff407BFF), // Customize color
                              child: IconButton(
                                icon: const Icon(
                                  FontAwesomeIcons.plus,
                                  color: Colors.white,
                                  size: 22,
                                ),
                                onPressed: () {},
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),

                  // Bottom spacing that animates
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    height: isSecondButtonSelected ? 225 : 0,
                  ),
                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: !isSecondButtonSelected ? 1.5 : 0,
              width: double.infinity,
              color: const Color(0xff3362CC),
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // First Button
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isSecondButtonSelected = false;
                      });
                      // Reverse the animation when switching to view mode
                      _animationController.reverse();
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
                      // Trigger animation when the button is pressed
                      _animationController.forward();
                      FocusScope.of(context)
                          .requestFocus(_focusNodeMovingWidget);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: !isSecondButtonSelected
                          ? const Color(0xFF3362CC) // Unselected color
                          : const Color(0xFF407BFF), // Selected color
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
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget noteEditor(BuildContext context, _focusNodeNoteContainer,
      Patient patient, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          focusedIndex = index;
        });
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: focusedIndex == index
                      ? const Color(0xffFFF9AD)
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
                          padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                          child: focusedIndex == index
                              ? TextField(
                                  controller: controllers[index],
                                  focusNode: _focusNodeNoteContainer,
                                  maxLines: null,
                                  style: const TextStyle(
                                      fontSize:
                                          14), // Set your desired font size here
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: patient.note,
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
                          ? Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Material(
                                elevation: 1,
                                shape: const CircleBorder(),
                                color: Colors.transparent,
                                child: CircleAvatar(
                                  radius: 15,
                                  backgroundColor: const Color(0xffFAD505),
                                  child: IconButton(
                                    icon: const Icon(
                                      FontAwesomeIcons.solidFloppyDisk,
                                      color: Colors.white,
                                      size: 15,
                                    ),
                                    onPressed: () {
                                      // Add save functionality here
                                    },
                                  ),
                                ),
                              ),
                            )
                          : IconButton(
                              icon: const Icon(
                                FontAwesomeIcons.penClip, // Edit Icon
                                color: Color(0xff3362CC),
                              ),
                              onPressed: () {
                                // Handle edit functionality
                                setState(() {
                                  focusedIndex = index;
                                });
                              },
                            ),
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
}

// Patient class for demonstration
class Patient {
  final String editBy;
  final String note;
  Patient({required this.editBy, required this.note});
}
