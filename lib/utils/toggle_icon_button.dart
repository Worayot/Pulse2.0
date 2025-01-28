import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ToggleIconButton extends StatefulWidget {
  final VoidCallback
      func; // Assuming the callback function doesn't require arguments
  const ToggleIconButton({super.key, required this.func});

  @override
  _ToggleIconButtonState createState() => _ToggleIconButtonState();
}

class _ToggleIconButtonState extends State<ToggleIconButton> {
  bool _isPlus = true; // Track whether the icon is plus or minus

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 30,
      height: 30,
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            _isPlus = !_isPlus;
          });
        },
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          backgroundColor: Colors.white,
          padding: const EdgeInsets.only(left: 2),
          elevation: 0,
        ),
        child: Center(
            child: Icon(
                _isPlus ? FontAwesomeIcons.plus : FontAwesomeIcons.minus,
                size: 25,
                color: _isPlus ? const Color(0xff3362CC) : Colors.red)),
      ),
    );
  }
}
